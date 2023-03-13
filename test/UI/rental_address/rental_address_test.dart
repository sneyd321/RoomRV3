import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/bloc_card/Cards/DetailCard.dart';
import 'package:notification_app/bloc_card/Cards/parking_description_card.dart';
import 'package:notification_app/bloc_card/FormFields/SimpleFormField.dart';
import 'package:notification_app/bloc_card/FormFields/SuggestedFormField.dart';
import 'package:notification_app/bloc_card/Wrappers/ItemLists/ParkingDescriptionList.dart';
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

  Future<void> addItemToList(WidgetTester tester, String enterText,
      [String addButtonText = "Add",
      String bottomSheetButtonText = "Add"]) async {
    await tester.tap(find.textContaining(addButtonText));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), enterText);
    await tester.pump();
    await tester.tap(find.text(bottomSheetButtonText));
    await tester.pumpAndSettle();
  }

  Future<void> submit(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(SimpleFormField), text);
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
  }

  testWidgets(
      "RentalAddress.streetNumber_IS_UPDATED_WHEN_RentalAddress_IS_Updated",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return rentalAddress.updateStreetNumber(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "Example");
    expect(rentalAddress.streetNumber, "Example");
  });

  testWidgets(
      "RentalAddress.streetName_IS_UPDATED_WHEN_RentalAddress_IS_Updated",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return rentalAddress.updateStreetName(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "Example");
    expect(rentalAddress.streetName, "Example");
  });

  testWidgets("RentalAddress.city_IS_UPDATED_WHEN_RentalAddress_IS_Updated",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return rentalAddress.updateCity(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "Example");
    expect(rentalAddress.city, "Example");
  });

  testWidgets("RentalAddress.province_IS_UPDATED_WHEN_RentalAddress_IS_Updated",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return rentalAddress.updateProvince(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "Example");
    expect(rentalAddress.province, "Example");
  });

  testWidgets(
      "RentalAddress.postalCode_IS_UPDATED_WHEN_RentalAddress_IS_Updated",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return rentalAddress.updatePostalCode(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "L6L 0E1");
    expect(rentalAddress.postalCode, "L6L 0E1");
  });

  testWidgets("RentalAddress.isCondo_IS_UPDATED_WHEN_RentalAddress_IS_Updated",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SwitchListTile(
        value: rentalAddress.isCondo,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(rentalAddress.isCondo
            ? "Yes, this property contains parking spaces"
            : "No, this property does not contain parking spaces"),
        onChanged: (value) {
          rentalAddress.updateIsCondo(value);
        });
    await tester.pumpWidget(getForm(formField));
    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();

    expect(rentalAddress.isCondo, true);
  });

  testWidgets("RentalAddress.unitName_IS_UPDATED_WHEN_RentalAddress_IS_Updated",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SuggestedFormField(
      icon: Icons.label,
      label: 'Unit Name',
      onSaved: (String? value) {},
      onValidate: (String? value) {
        return rentalAddress.updateUnitName(value);
      },
      suggestedNames: ["Basement"],
      textEditingController: TextEditingController(),
    );
    await tester.pumpWidget(getForm(formField));
    await tester.enterText(find.byType(SuggestedFormField),"Basem");
    await tester.pumpAndSettle();
    await tester.tap(find.text("Basement"));
    await tester.pump();
    await tester.tap(find.text("Test"));
    expect(rentalAddress.unitName, "Basement");
  });

   testWidgets("List_of_ParkingDescription_IS_UPDATED_WHEN_ParkingDescription_IS_Added",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    await tester.pumpWidget(getForm(ParkingDescriptionsList(rentalAddress: rentalAddress)));
    await addItemToList(tester, "asdf");
    expect(find.byType(ParkingDescriptionCard), findsOneWidget);
  });

  testWidgets("List_of_ParkingDescription_IS_UPDATED_WHEN_ParkingDescription_IS_Removed",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    await tester.pumpWidget(getForm(ParkingDescriptionsList(rentalAddress: rentalAddress)));
    await addItemToList(tester, "asdf");
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(find.byType(ParkingDescriptionCard), findsNothing);
  });


  testWidgets(
      "Please_enter_a_street_number_IS_RETURNED_WHEN_RentalAddress_IS_Error-Invalid_Request",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return rentalAddress.updateStreetNumber(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "");
    expect(find.text("Please enter a street number."), findsOneWidget);
  });

  testWidgets(
      "Please_enter_a_street_name_IS_RETURNED_WHEN_RentalAddress_IS_Error-Invalid_Request",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return rentalAddress.updateStreetName(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "");
    expect(find.text("Please enter a street name."), findsOneWidget);
  });

  testWidgets(
      "Please_enter_a_city_IS_RETURNED_WHEN_RentalAddress_IS_Error-Invalid_Request",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return rentalAddress.updateCity(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "");
    expect(find.text("Please enter a city."), findsOneWidget);
  });

  testWidgets(
      "Please_enter_a_postal_code_IS_RETURNED_WHEN_RentalAddress_IS_Error-Invalid_Request",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return rentalAddress.updatePostalCode(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "");
    expect(find.text("Please enter a postal code."), findsOneWidget);
  });

  testWidgets(
      "Please_enter_a_valid_postal_code_IS_RETURNED_WHEN_RentalAddress_IS_Error-Invalid_Request",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return rentalAddress.updatePostalCode(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "l6l 0e1");
    expect(find.text("Please enter a valid postal code."), findsOneWidget);
  });

  testWidgets(
      "Please_enter_a_unit_name_IS_RETURNED_WHEN_RentalAddress_IS_Error-Invalid_Request",
      (tester) async {
   RentalAddress rentalAddress = RentalAddress();
    Widget formField = SuggestedFormField(
      icon: Icons.label,
      label: 'Unit Name',
      onSaved: (String? value) {},
      onValidate: (String? value) {
        return rentalAddress.updateUnitName(value);
      },
      suggestedNames: ["Basement"],
      textEditingController: TextEditingController(),
    );
    await tester.pumpWidget(getForm(formField));
    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter a unit name."), findsOneWidget);
  });

   testWidgets("Parking_description_already_added_IS_RETURNED_WHEN_List_of_ParkingDescription_IS_Error-Resource_Exists",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    await tester.pumpWidget(getForm(ParkingDescriptionsList(rentalAddress: rentalAddress)));
    await addItemToList(tester, "asdf");
    await addItemToList(tester, "asdf");
    expect(find.text("Error asdf already exists."), findsOneWidget);
  });

    testWidgets("ParkingDescription_IS_REMOVED_WHEN_List_of_ParkingDescription_IS_Error-Resource_Exists",
      (tester) async {
    RentalAddress rentalAddress = RentalAddress();
    await tester.pumpWidget(getForm(ParkingDescriptionsList(rentalAddress: rentalAddress)));
    await addItemToList(tester, "asdf");
    await addItemToList(tester, "asdf");
    expect(rentalAddress.parkingDescriptions.length, 1);
  });


  
}
