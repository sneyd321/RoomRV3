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
    RentService rentService = CustomRentService("", "");
    Widget formField = SimpleFormField(
        label: "label",
        icon: Icons.abc,
        textEditingController: TextEditingController(),
        onSaved: (value) {},
        onValidate: (value) {
          return rentService.updateName(value!);
        });
    await tester.pumpWidget(getForm(formField));

    await submit(tester, "Example");
    expect(rentService.name, "Example");
  });

  testWidgets("amount_IS_UPDATED_WHEN_RentService_IS_Updated", (tester) async {
    RentService rentService = CustomRentService("", "");
    Widget formField = TextFormField(
        controller: TextEditingController(),
        keyboardType: TextInputType.number,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: "Label",
        ),
        validator: (String? value) {
          return rentService.updateAmount(value!);
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
        ]);
    await tester.pumpWidget(getForm(formField));

    await tester.enterText(find.byType(TextFormField), "2000");
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(rentService.amount, "2,000.00");
  });

  testWidgets("Please_enter_a_name_IS_RETURNED_WHEN_RentService_IS_Error-Invalid_Request", (tester) async {
    RentService rentService = CustomRentService("", "");
    Widget formField = SimpleFormField(
        label: "label",
        icon: Icons.abc,
        textEditingController: TextEditingController(),
        onSaved: (value) {},
        onValidate: (value) {
          return rentService.updateName(value!);
        });
    await tester.pumpWidget(getForm(formField));

    await submit(tester, "");
    expect(find.text("Please enter a name."), findsOneWidget);
  });


  testWidgets("Please_enter_an_amount_IS_RETURNED_WHEN_RentService_IS_Error-Invalid_Request", (tester) async {
    RentService rentService = CustomRentService("", "");
    Widget formField = TextFormField(
        controller: TextEditingController(),
        keyboardType: TextInputType.number,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: "Label",
        ),
        validator: (String? value) {
          return rentService.updateAmount(value!);
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


  testWidgets("Please_enter_an_amount_IS_RETURNED_WHEN_RentService_IS_Error-Invalid_Request", (tester) async {
    RentService rentService = CustomRentService("", "");
    Widget formField = TextFormField(
        controller: TextEditingController(),
        keyboardType: TextInputType.number,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: "Label",
        ),
        validator: (String? value) {
          return rentService.updateAmount(value!);
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
        ]);
    await tester.pumpWidget(getForm(formField));

    await tester.enterText(find.byType(TextFormField), ".1231d..");
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter a valid amount."), findsOneWidget);
  });


}
