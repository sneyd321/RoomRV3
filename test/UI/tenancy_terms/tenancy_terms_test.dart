import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/bloc_card/Cards/DetailCard.dart';
import 'package:notification_app/bloc_card/Cards/RentServiceCard.dart';
import 'package:notification_app/bloc_card/FormFields/PaymentPeriodRadioGroup.dart';
import 'package:notification_app/bloc_card/FormFields/RentDueDateRadioGroup.dart';
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

  testWidgets("rentDueDate_IS_UPDATED_WHEN_rentDueDate=First_IS_Updated",
      (tester) async {
    TenancyTerms tenancyTerms = TenancyTerms();
    tenancyTerms.updateRentDueDate(RentDueDateOption.last);
    await tester
        .pumpWidget(getForm(RentDueDateRadioGroup(tenancyTerms: tenancyTerms)));
    await tester.tap(find.text("First Day"));
    await tester.pump();
    expect(
        tester
            .getSemantics(find.text("First Day"))
            .getSemanticsData()
            .hasFlag(SemanticsFlag.hasCheckedState),
        true);
  });

  testWidgets("rentDueDate_IS_UPDATED_WHEN_rentDueDate=Last_IS_Updated",
      (tester) async {
    TenancyTerms tenancyTerms = TenancyTerms();
    await tester
        .pumpWidget(getForm(RentDueDateRadioGroup(tenancyTerms: tenancyTerms)));
    await tester.tap(find.text("Last Day"));
    await tester.pump();
    expect(
        tester
            .getSemantics(find.text("Last Day"))
            .getSemanticsData()
            .hasFlag(SemanticsFlag.hasCheckedState),
        true);
  });

  testWidgets("startDate_IS_UPDATED_WHEN_TenancyTerms_IS_Updated",
      (tester) async {
    TenancyTerms tenancyTerms = TenancyTerms();
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "Start Date",
        onSaved: (value) {},
        onValidate: (value) {
          return tenancyTerms.updateStartDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.byType(TextFormField));
    await tester.pumpAndSettle();
    await tester.tap(find.text("1"));
    await tester.pump();
    await tester.tap(find.text("OK"));
    await tester.pump();
    await tester.tap(find.text("Test"));

    expect(tenancyTerms.startDate, getDayOfCurrentMonth(1));
  });

  testWidgets("paymentPeriod_IS_UPDATED_WHEN_paymentPeriod=Monthly_IS_Updated",
      (tester) async {
    TenancyTerms tenancyTerms = TenancyTerms();
    tenancyTerms.updatePaymentPeriod(PaymentPeriodOption.daily);
    await tester
        .pumpWidget(getForm(PaymentPeriodRadioGroup(tenancyTerms: tenancyTerms, notify: (TenancyTerms tenancyTerms) {  },)));
    await tester.tap(find.text("Month"));
    await tester.pump();
    expect(
        tester
            .getSemantics(find.text("Month"))
            .getSemanticsData()
            .hasFlag(SemanticsFlag.hasCheckedState),
        true);
  });

  testWidgets("paymentPeriod_IS_UPDATED_WHEN_paymentPeriod=Weekly_IS_Updated",
      (tester) async {
    TenancyTerms tenancyTerms = TenancyTerms();
    await tester
        .pumpWidget(getForm(PaymentPeriodRadioGroup(tenancyTerms: tenancyTerms, notify: (TenancyTerms tenancyTerms) {  },)));
    await tester.tap(find.text("Week"));
    await tester.pump();
    expect(
        tester
            .getSemantics(find.text("Week"))
            .getSemanticsData()
            .hasFlag(SemanticsFlag.hasCheckedState),
        true);
  });

  testWidgets("paymentPeriod_IS_UPDATED_WHEN_paymentPeriod=Daily_IS_Updated",
      (tester) async {
    TenancyTerms tenancyTerms = TenancyTerms();
    await tester
        .pumpWidget(getForm(PaymentPeriodRadioGroup(tenancyTerms: tenancyTerms, notify: (TenancyTerms tenancyTerms) {  },)));
    await tester.tap(find.text("Days"));
    await tester.pump();
    expect(
        tester
            .getSemantics(find.text("Days"))
            .getSemanticsData()
            .hasFlag(SemanticsFlag.hasCheckedState),
        true);
  });

  testWidgets("rentDueDate_IS_UPDATED_WHEN_paymentPeriod=Daily_IS_Updated",
      (tester) async {
    TenancyTerms tenancyTerms = TenancyTerms();
    await tester
        .pumpWidget(getForm(Column(
          children: [
            RentDueDateRadioGroup(tenancyTerms: tenancyTerms),
            PaymentPeriodRadioGroup(tenancyTerms: tenancyTerms, notify: (TenancyTerms terms) { 
              tenancyTerms = terms;
             },),
          ],
        )));
    await tester.tap(find.text("Days"));
    await tester.pump();
    
    expect(
        tester
            .getSemantics(find.text("First Day"))
            .getSemanticsData()
            .hasFlag(SemanticsFlag.hasCheckedState),
        true);
  });

  testWidgets("startDate_IS_UPDATED_WHEN_TenancyTerms_IS_Updated",
      (tester) async {
    TenancyTerms tenancyTerms = TenancyTerms();
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "Start Date",
        onSaved: (value) {},
        onValidate: (value) {
          return tenancyTerms.updateStartDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter a start date."), findsOneWidget);
  });

  testWidgets("Please_enter_a_start_date_before_end_date_IS_RETURNED_WHEN_RentalPeriod=Fixed_Term_IS_Error-Invalid_Request",
      (tester) async {
    TenancyTerms tenancyTerms = TenancyTerms();
     RentalPeriod rentalPeriod = tenancyTerms.rentalPeriod;
    rentalPeriod.updateRentalPeriod(RentalPeriodOption.fixedTerm);
    rentalPeriod.updateEndDate(getDayOfCurrentMonth(1));
    tenancyTerms.updateRentalPeriod(rentalPeriod);
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "Start Date",
        onSaved: (value) {},
        onValidate: (value) {
          return tenancyTerms.updateStartDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.byType(TextFormField));
    await tester.pumpAndSettle();
    await tester.tap(find.text("2"));
    await tester.pump();
    await tester.tap(find.text("OK"));
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();

    expect(find.text("Please enter a start date before end date."), findsOneWidget);
  });

}
