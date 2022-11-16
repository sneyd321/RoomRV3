import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/FormFields/SimpleFormField.dart';


void main() {
  Widget getForm(Field field) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          SimpleFormField(
              label: "label",
              icon: Icons.abc,
              textEditingController: TextEditingController(),
              onSaved: (value) {},
              field: field),
          PrimaryButton(Icons.abc, "Test", ((context) {
            formKey.currentState!.validate();
          }))
        ],
      ),
    );
  }

  Widget getApp(Widget widget) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(body: widget),
    ));
  }

  testWidgets(
      "SimpleFormField_validates_based_on_field_validate_call",
      (tester) async {
    Widget formField = getForm(Name(""));
    await tester.pumpWidget(getApp(formField));
    await tester.tap(find.text("Test"));
    await tester.pump();

    expect(find.textContaining("Please enter a name."), findsOneWidget);
  });

   testWidgets(
      "Postal_code_is_validated_on_invalid_value",
      (tester) async {
    Widget formField = getForm(PostalCode(""));
    await tester.pumpWidget(getApp(formField));

    await tester.enterText(find.byType(TextField).first, "text");
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
    

    expect(find.textContaining("Please enter a valid postal code."), findsOneWidget);
  });
}
