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

  

  testWidgets("amount_IS_UPDATED_WHEN_PartialPeriod_IS_Updated",
      (tester) async {
    PartialPeriod partialPeriod = PartialPeriod();
    Widget formField = SimpleFormField(
        label: "label",
        icon: Icons.abc,
        textEditingController: TextEditingController(),
        onSaved: (value) {},
        onValidate: (value) {
          return partialPeriod.updateAmount(value!);
        });
    await tester.pumpWidget(getForm(formField));

    await submit(tester, "100");
    expect(partialPeriod.amount, "100.00");
  });

   testWidgets("dueDate_IS_UPDATED_WHEN_PartialPeriod_IS_Updated",
      (tester) async {
    PartialPeriod partialPeriod = PartialPeriod();
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "Due Date",
        onSaved: (value) {},
        onValidate: (value) {
          return partialPeriod.updateDueDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.byType(TextFormField));
    await tester.pumpAndSettle();
    await tester.tap(find.text("1"));
    await tester.pump();
    await tester.tap(find.text("OK"));
    await tester.pump();
    await tester.tap(find.text("Test"));


    expect(partialPeriod.dueDate, getDayOfCurrentMonth(1));
  });

  testWidgets("startDate_IS_UPDATED_WHEN_PartialPeriod_IS_Updated",
      (tester) async {
    PartialPeriod partialPeriod = PartialPeriod();
    partialPeriod.updateEndDate(getDayOfCurrentMonth(2));
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "Start Date",
        onSaved: (value) {},
        onValidate: (value) {
          return partialPeriod.updateStartDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.byType(TextFormField));
    await tester.pumpAndSettle();
    await tester.tap(find.text("1"));
    await tester.pump();
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Test"));

    expect(partialPeriod.startDate, getDayOfCurrentMonth(1));
  });

  testWidgets("endDate_IS_UPDATED_WHEN_PartialPeriod_IS_Updated",
      (tester) async {
    PartialPeriod partialPeriod = PartialPeriod();
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "End Date",
        onSaved: (value) {},
        onValidate: (value) {
          return partialPeriod.updateEndDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.byType(TextFormField));
    await tester.pumpAndSettle();
    await tester.tap(find.text("1"));
    await tester.pump();
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Test"));

    expect(partialPeriod.endDate, getDayOfCurrentMonth(1));
  });

  
  testWidgets("Please_enter_an_due_date_IS_RETURNED_WHEN_PartialPeriod_IS_Error-Invalid_Request",
      (tester) async {
    PartialPeriod partialPeriod = PartialPeriod();
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "Due Date",
        onSaved: (value) {},
        onValidate: (value) {
          return partialPeriod.updateDueDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter a due date."), findsOneWidget);
  });

  testWidgets("Please_enter_a_start_date_IS_RETURNED_WHEN_PartialPeriod_IS_Error-Invalid_Request",
      (tester) async {
    PartialPeriod partialPeriod = PartialPeriod();
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "Start Date",
        onSaved: (value) {},
        onValidate: (value) {
          return partialPeriod.updateStartDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter a start date."), findsOneWidget);
  });

  testWidgets("Please_enter_a_start_date_before_end_date_IS_RETURNED_WHEN_PartialPeriod_IS_Error-Invalid_Request",
      (tester) async {
    PartialPeriod partialPeriod = PartialPeriod();
    partialPeriod.updateEndDate(getDayOfCurrentMonth(1));
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "End Date",
        onSaved: (value) {},
        onValidate: (value) {
          return partialPeriod.updateStartDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.byType(TextFormField));
    await tester.pumpAndSettle();
    await tester.tap(find.text("2"));
    await tester.pump();
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter a start date before end date."), findsOneWidget);
  });

  testWidgets("Please_enter_an_end_date_IS_RETURNED_WHEN_PartialPeriod_IS_Error-Invalid_Request",
      (tester) async {
    PartialPeriod partialPeriod = PartialPeriod();
    await tester.pumpWidget(getForm(SimpleDatePicker(
        label: "End Date",
        onSaved: (value) {},
        onValidate: (value) {
          return partialPeriod.updateEndDate(value!);
        },
        textEditingController: TextEditingController())));

    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter an end date."), findsOneWidget);
  });


  testWidgets("Please_enter_an_amount_IS_RETURNED_WHEN_PartialPeriod_IS_Error-Invalid_Request",
      (tester) async {
    PartialPeriod partialPeriod = PartialPeriod();
    Widget formField = SimpleFormField(
        label: "label",
        icon: Icons.abc,
        textEditingController: TextEditingController(),
        onSaved: (value) {},
        onValidate: (value) {
          return partialPeriod.updateAmount(value!);
        });
    await tester.pumpWidget(getForm(formField));

    await submit(tester, "");
    expect(find.text("Please enter an amount."), findsOneWidget);
  });

  testWidgets("Please_enter_a_valid_amount_IS_RETURNED_WHEN_PartialPeriod_IS_Error-Invalid_Request",
      (tester) async {
    PartialPeriod partialPeriod = PartialPeriod();
    Widget formField = SimpleFormField(
        label: "label",
        icon: Icons.abc,
        textEditingController: TextEditingController(),
        onSaved: (value) {},
        onValidate: (value) {
          return partialPeriod.updateAmount(value!);
        });
    await tester.pumpWidget(getForm(formField));

    await submit(tester, "123..123");
    expect(find.text("Please enter a valid amount."), findsOneWidget);
  });



}