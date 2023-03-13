import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/bloc_card/Cards/DetailCard.dart';
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

  testWidgets("name_IS_UPDATED_WHEN_ParkingDescription_IS_Updated", (tester) async {
    ParkingDescription parkingDescription = ParkingDescription();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return parkingDescription.updateDescription(value!);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "Example");
    expect(parkingDescription.name, "Example");
  });

  testWidgets("Please_enter_a_description_IS_RETURNED_WHEN_ParkingDescription_IS_Error-Invalid_Request", (tester) async {
    ParkingDescription parkingDescription = ParkingDescription();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return parkingDescription.updateDescription(value!);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "");
    expect(find.text("Please enter a description of the parking space."), findsOneWidget);
  });
}