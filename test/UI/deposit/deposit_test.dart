import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/bloc_card/Cards/DetailCard.dart';
import 'package:notification_app/bloc_card/Cards/RentServiceCard.dart';
import 'package:notification_app/bloc_card/FormFields/SimpleFormField.dart';
import 'package:notification_app/bloc_card/Wrappers/ItemLists/DepositDetailsList.dart';
import 'package:notification_app/bloc_card/Wrappers/ItemLists/PaymentOptionsList.dart';
import 'package:notification_app/bloc_card/Wrappers/ItemLists/RentDiscountDetailsList.dart';
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

  Future<void> addItemToList(WidgetTester tester, String name, 
      [String addButtonText = "Add",
      String bottomSheetButtonText = "Add"]) async {
    await tester.tap(find.textContaining(addButtonText));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), name);
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

  testWidgets("amount_IS_UPDATED_WHEN_RentDeposit_IS_Updated", (tester) async {
    Deposit deposit = CustomDeposit("", "");
    Widget formField = TextFormField(
        controller: TextEditingController(),
        keyboardType: TextInputType.number,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: "Amount",
        ),
        validator: (String? value) {
          return deposit.updateAmount(value!);
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
        ]);
    await tester.pumpWidget(getForm(formField));

    await tester.enterText(find.byType(TextFormField), "200");
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(deposit.amount, "200.00");
  });

  testWidgets("name_IS_UPDATED_WHEN_RentDeposit_IS_Updated", (tester) async {
    Deposit deposit = CustomDeposit("", "");
    Widget formField = SimpleFormField(
        label: "label",
        icon: Icons.abc,
        textEditingController: TextEditingController(),
        onSaved: (value) {},
        onValidate: (value) {
          return deposit.updateName(value!);
        });
    await tester.pumpWidget(getForm(formField));

    await submit(tester, "Example");
    expect(deposit.name, "Example");
  });

  testWidgets("List_of_Detail_IS_RETURNED_WHEN_RentDeposit_IS_Added",
      (tester) async {
    Deposit deposit = CustomDeposit("", "");
    await tester.pumpWidget(getForm(DepositDetailsList(
      deposit: deposit,
    )));
    await addItemToList(tester, "asdf");
    expect(find.byType(DetailCard), findsNWidgets(1));
  });

  testWidgets("List_of_Detail_IS_RETURNED_WHEN_RentDeposit_IS_Removed",
      (tester) async {
   Deposit deposit = CustomDeposit("", "");
    await tester.pumpWidget(getForm(DepositDetailsList(
      deposit: deposit,
    )));
    await addItemToList(tester, "asdf");
    await tester.tap(find.byIcon(Icons.close).at(0));
    await tester.pump();
    expect(find.byType(DetailCard), findsNWidgets(0));
  });

  testWidgets(
      "Please_enter_an_amount_IS_RETURNED_WHEN_RentDeposit_IS_Error-Invalid_Request",
      (tester) async {
   Deposit deposit = CustomDeposit("", "");
    Widget formField = TextFormField(
        controller: TextEditingController(),
        keyboardType: TextInputType.number,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: "Amount",
        ),
        validator: (String? value) {
          return deposit.updateAmount(value!);
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
        ]);
    await tester.pumpWidget(getForm(formField));

    await tester.enterText(find.byType(TextFormField), "");
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter an amount."), findsOneWidget);
  });

  testWidgets(
      "Please_enter_a_valid_amount_IS_RETURNED_WHEN_RentDeposit_IS_Error-Invalid_Request",
      (tester) async {
    Deposit deposit = CustomDeposit("", "");
    Widget formField = TextFormField(
        controller: TextEditingController(),
        keyboardType: TextInputType.number,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: "Amount",
        ),
        validator: (String? value) {
          return deposit.updateAmount(value!);
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
        ]);
    await tester.pumpWidget(getForm(formField));

    await tester.enterText(find.byType(TextFormField), "...123");
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter a valid amount."), findsOneWidget);
  });

  testWidgets(
      "Please_enter_a_name_IS_RETURNED_WHEN_RentDeposit_IS_Error-Invalid_Request",
      (tester) async {
    Deposit deposit = CustomDeposit("", "");
    Widget formField = SimpleFormField(
        label: "label",
        icon: Icons.abc,
        textEditingController: TextEditingController(),
        onSaved: (value) {},
        onValidate: (value) {
          return deposit.updateName(value!);
        });
    await tester.pumpWidget(getForm(formField));

    await submit(tester, "");
    expect(
        find.text("Please enter a name."), findsOneWidget);
  });

 

  testWidgets(
      "Detail_already_exists_IS_RETURNED_WHEN_List_of_Detail_IS_Error-Resource_Exists",
      (tester) async {
    Deposit deposit = CustomDeposit("", "");

    await tester.pumpWidget(getForm(DepositDetailsList(deposit: deposit)));

    await addItemToList(tester, "Parking");
    await addItemToList(tester, "Parking");
    expect(find.text("Error Parking already exists."), findsOneWidget);
  });

  testWidgets(
      "Detail_IS_REMOVED_WHEN_List_of_Detail_IS_Error-Resource_Exists",
      (tester) async {
    Deposit deposit = CustomDeposit("", "");

    await tester.pumpWidget(getForm(DepositDetailsList(deposit: deposit)));

    await addItemToList(tester, "Parking");
    await addItemToList(tester, "Parking");
    expect(deposit.details.length, 1);
  });

}
