import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/bloc_card/Cards/DetailCard.dart';
import 'package:notification_app/bloc_card/Cards/RentServiceCard.dart';
import 'package:notification_app/bloc_card/FormFields/SimpleFormField.dart';
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


   testWidgets("name_IS_UPDATED_WHEN_RentService_IS_Updated", (tester) async {
    PaymentOption paymentOption = CustomPaymentOption("");
    Widget formField = SimpleFormField(
        label: "label",
        icon: Icons.abc,
        textEditingController: TextEditingController(),
        onSaved: (value) {},
        onValidate: (value) {
          return paymentOption.updateName(value!);
        });
    await tester.pumpWidget(getForm(formField));

    await submit(tester, "Example");
    expect(paymentOption.name, "Example");
  });

  testWidgets("name_IS_UPDATED_WHEN_RentService_IS_Updated", (tester) async {
    PaymentOption paymentOption = CustomPaymentOption("");
    Widget formField = SimpleFormField(
        label: "label",
        icon: Icons.abc,
        textEditingController: TextEditingController(),
        onSaved: (value) {},
        onValidate: (value) {
          return paymentOption.updateName(value!);
        });
    await tester.pumpWidget(getForm(formField));

    await submit(tester, "");
    expect(find.text("Please enter a name."), findsOneWidget);
  });


}