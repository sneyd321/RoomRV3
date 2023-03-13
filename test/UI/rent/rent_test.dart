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

  testWidgets("baseRent_IS_UPDATED_WHEN_Rent_IS_Updated", (tester) async {
    Rent rent = Rent();
    Widget formField = TextFormField(
        controller: TextEditingController(),
        keyboardType: TextInputType.number,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: "Base Rent",
        ),
        validator: (String? value) {
          return rent.updateBaseRent(value!);
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
        ]);
    await tester.pumpWidget(getForm(formField));

    await tester.enterText(find.byType(TextFormField), "2000");
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(rent.baseRent, "2,000.00");
  });

  testWidgets("rentMadePayableTo_IS_UPDATED_WHEN_Rent.baseRent_IS_Updated",
      (tester) async {
    Rent rent = Rent();
    Widget formField = SimpleFormField(
        label: "label",
        icon: Icons.abc,
        textEditingController: TextEditingController(),
        onSaved: (value) {},
        onValidate: (value) {
          return rent.updateRentMadePayableTo(value);
        });
    await tester.pumpWidget(getForm(formField));

    await submit(tester, "Ryan Sneyd");
    expect(rent.rentMadePayableTo, "Ryan Sneyd");
  });

  testWidgets("RentService_IS_ADDED_WHEN_Rent_IS_Updated", (tester) async {
    Rent rent = Rent();
    await tester.pumpWidget(getForm(RentServicesList(
      rent: rent,
      notify: () {},
    )));
    await addItemToList(tester, "asdf", "20");
    expect(find.byType(RentServiceCard), findsNWidgets(2));
  });

  testWidgets("RentService_IS_REMOVED_WHEN_Rent_IS_Updated", (tester) async {
    Rent rent = Rent();
    await tester.pumpWidget(getForm(RentServicesList(
      rent: rent,
      notify: () {},
     
    )));
    await addItemToList(tester, "asdf", "20");
    await tester.tap(find.byIcon(Icons.close).at(1));
    await tester.pump();
    expect(find.byType(RentServiceCard), findsNWidgets(1));
  });

  testWidgets(
      "Please_enter_a_base_rent_IS_RETURNED_WHEN_Rent_IS_Error-Invalid_Request",
      (tester) async {
    Rent rent = Rent();
    Widget formField = TextFormField(
        controller: TextEditingController(),
        keyboardType: TextInputType.number,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: "Base Rent",
        ),
        validator: (String? value) {
          return rent.updateBaseRent(value!);
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
        ]);
    await tester.pumpWidget(getForm(formField));

    await tester.enterText(find.byType(TextFormField), "");
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter base rent."), findsOneWidget);
  });

  testWidgets(
      "Please_enter_a_valid_base_rent_IS_RETURNED_WHEN_Rent_IS_Error-Invalid_Request",
      (tester) async {
    Rent rent = Rent();
    Widget formField = TextFormField(
        controller: TextEditingController(),
        keyboardType: TextInputType.number,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: "Base Rent",
        ),
        validator: (String? value) {
          return rent.updateBaseRent(value!);
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
        ]);
    await tester.pumpWidget(getForm(formField));

    await tester.enterText(find.byType(TextFormField), "...123");
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter a valid base rent."), findsOneWidget);
  });

  testWidgets(
      "Please_enter_who_rent_is_made_payable_to_IS_RETURNED_WHEN_Rent_IS_Error-Invalid_Request",
      (tester) async {
    Rent rent = Rent();
    Widget formField = SimpleFormField(
        label: "label",
        icon: Icons.abc,
        textEditingController: TextEditingController(),
        onSaved: (value) {},
        onValidate: (value) {
          return rent.updateRentMadePayableTo(value);
        });
    await tester.pumpWidget(getForm(formField));

    await submit(tester, "");
    expect(
        find.text("Please enter who rent is made payable to."), findsOneWidget);
  });

  testWidgets(
      "Parking_is_a_required_service_IS_RETURNED_WHEN_Rent_IS_Error-Invalid_Request",
      (tester) async {
    Rent rent = Rent();

    await tester.pumpWidget(getForm(RentServicesList(
        rent: rent, notify: () {})));

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(
        find.text("Error Parking is a required service."), findsOneWidget);
  });

  testWidgets(
      "ParkingRentService_IS_ADDED_WHEN_List_of_RentService_IS_Error-Invalid_Request",
      (tester) async {
    Rent rent = Rent();

    await tester.pumpWidget(getForm(RentServicesList(
        rent: rent, notify: () {},)));

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(
        rent.rentServices.length, 1);
  });

  testWidgets(
      "Service_already_exists_IS_RETURNED_WHEN_List_of_RentService_IS_Error-Resource_Exists",
      (tester) async {
    Rent rent = Rent();

    await tester.pumpWidget(getForm(RentServicesList(
        rent: rent, notify: () {})));

    await addItemToList(tester, "Parking", "0");
    expect(
        find.text("Error Parking already exists."), findsOneWidget);
  });

  testWidgets(
      "Payment_option_already_exists_IS_RETURNED_WHEN_List_of_PaymentOption_IS_Error-Resource_Exists",
      (tester) async {
    Rent rent = Rent();
    await tester.pumpWidget(getForm(PaymentOptionsList(rent: rent)));
     await tester.tap(find.textContaining("Add"));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), "Cash");
    await tester.pumpAndSettle();
    await tester.tap(find.text("Add"));
    await tester.pumpAndSettle();
    expect(
        find.text("Error Cash already exists."), findsOneWidget);
  });

  testWidgets(
      "Payment_Option_IS_REMOVED_WHEN_List_of_PaymentOption_IS_Error-Resource_Exists",
      (tester) async {
    Rent rent = Rent();
    await tester.pumpWidget(getForm(PaymentOptionsList(rent: rent)));
     await tester.tap(find.textContaining("Add"));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), "Cash");
    await tester.pumpAndSettle();
    await tester.tap(find.text("Add"));
    await tester.pumpAndSettle();
    expect(
       rent.paymentOptions.length, 3);
  });
}
