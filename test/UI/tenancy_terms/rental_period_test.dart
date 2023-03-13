import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/bloc_card/Cards/DetailCard.dart';
import 'package:notification_app/bloc_card/Cards/RentServiceCard.dart';
import 'package:notification_app/bloc_card/FormFields/PaymentPeriodRadioGroup.dart';
import 'package:notification_app/bloc_card/FormFields/RentDueDateRadioGroup.dart';
import 'package:notification_app/bloc_card/FormFields/RentalPeriodRadioGroup.dart';
import 'package:notification_app/bloc_card/FormFields/SimpleDatePicker.dart';
import 'package:notification_app/bloc_card/FormFields/SimpleFormField.dart';
import 'package:notification_app/bloc_card/FormFields/SimpleRadioGroup.dart';
import 'package:notification_app/bloc_card/Wrappers/ItemLists/PaymentOptionsList.dart';
import 'package:notification_app/bloc_card/Wrappers/ItemLists/RentServicesList.dart';
import 'package:notification_app/bloc_card/buttons/CallToActionButton.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

void main() {
  Widget getForm(Widget formField) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            children: [
              formField,
              CallToActionButton(
                  text: "Test",
                  onClick: () {
                    formKey.currentState!.validate();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addItemToList(WidgetTester tester, String name, String amount,
      [String addButtonText = "Add",
      String bottomSheetButtonText = "Add"]) async {
    await tester.tap(find.textContaining(addButtonText));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), name);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(1), amount);
    await tester.pumpAndSettle();
    await tester.tap(find.text(bottomSheetButtonText));
    await tester.pumpAndSettle();
  }

  Future<void> submit(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(SimpleFormField), text);
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
  }

  String getDayOfCurrentMonth(int day) {
    DateTime now = DateTime.now();
    DateTime dayOfMonth = DateTime(now.year, now.month, day);
    return DateFormat('yyyy/MM/dd').format(dayOfMonth);
  }

  testWidgets("rentalPeriod_IS_UPDATED_WHEN_RentalPeriod=Fixed_Term_IS_Updated",
      (tester) async {
    RentalPeriod rentalPeriod = RentalPeriod();
    rentalPeriod.updateRentalPeriod(RentalPeriodOption.monthly);
    await tester.pumpWidget(getForm(
      RadioListTile(
          contentPadding: const EdgeInsets.all(0),
          title: const Text("Fixed Term"),
          value: "Fixed Term",
          groupValue: rentalPeriod.rentalPeriod,
          onChanged: (String? value) {
            RentalPeriod rentalPeriod = RentalPeriod();
            rentalPeriod.updateRentalPeriod(RentalPeriodOption.fixedTerm);
          }),
    ));
    await tester.tap(find.text("Fixed Term"));
    await tester.pump();
    expect(
        tester
            .getSemantics(find.text("Fixed Term"))
            .getSemanticsData()
            .hasFlag(SemanticsFlag.hasCheckedState),
        true);
  });

  testWidgets("rentalPeriod_IS_UPDATED_WHEN_RentalPeriod=Fixed_Term_IS_Updated",
      (tester) async {
    RentalPeriod rentalPeriod = RentalPeriod();
    await tester.pumpWidget(getForm(RentalPeriodRadioGroup(
        rentalPeriod: rentalPeriod, notify: (rentalPeriod) {})));
    await tester.tap(find.text("Monthly"));
    await tester.pump();
    expect(
        tester
            .getSemantics(find.text("Monthly"))
            .getSemanticsData()
            .hasFlag(SemanticsFlag.hasCheckedState),
        true);
  });

  testWidgets("rentalPeriod_IS_UPDATED_WHEN_RentalPeriod=Weekly_IS_Updated",
      (tester) async {
    RentalPeriod rentalPeriod = RentalPeriod();
    await tester.pumpWidget(getForm(RentalPeriodRadioGroup(
        rentalPeriod: rentalPeriod, notify: (rentalPeriod) {})));
    await tester.tap(find.text("Bi-Weekly"));
    await tester.pump();
    expect(
        tester
            .getSemantics(find.text("Bi-Weekly"))
            .getSemanticsData()
            .hasFlag(SemanticsFlag.hasCheckedState),
        true);
  });

  testWidgets("rentalPeriod_IS_UPDATED_WHEN_RentalPeriod=Weekly_IS_Updated",
      (tester) async {
    RentalPeriod rentalPeriod = RentalPeriod();
    await tester.pumpWidget(getForm(RentalPeriodRadioGroup(
        rentalPeriod: rentalPeriod, notify: (rentalPeriod) {})));
    await tester.tap(find.text("Weekly"));
    await tester.pump();
    expect(
        tester
            .getSemantics(find.text("Weekly"))
            .getSemanticsData()
            .hasFlag(SemanticsFlag.hasCheckedState),
        true);
  });

  testWidgets("startDate_IS_UPDATED_WHEN_TenancyTerms_IS_Updated",
      (tester) async {
    RentalPeriod rentalPeriod = RentalPeriod();
    rentalPeriod.updateRentalPeriod(RentalPeriodOption.fixedTerm);
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "End Date",
        onSaved: (value) {},
        onValidate: (value) {
          return rentalPeriod.updateEndDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.byType(TextFormField));
    await tester.pumpAndSettle();
    await tester.tap(find.text("1"));
    await tester.pump();
    await tester.tap(find.text("OK"));
    await tester.pump();
    await tester.tap(find.text("Test"));

    expect(rentalPeriod.endDate, getDayOfCurrentMonth(1));
  });

  testWidgets("Please_enter_an_end_date_IS_RETURNED_WHEN_RentalPeriod_IS_Error-Invalid_Request",
      (tester) async {
    RentalPeriod rentalPeriod = RentalPeriod();
    rentalPeriod.updateRentalPeriod(RentalPeriodOption.fixedTerm);
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "End Date",
        onSaved: (value) {},
        onValidate: (value) {
          return rentalPeriod.updateEndDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.text("Test"));
    await tester.pump();

    expect(find.text("Please enter an end date."), findsOneWidget);
  });
}
