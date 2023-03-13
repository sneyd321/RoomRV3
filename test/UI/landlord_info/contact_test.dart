import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/bloc_card/FormFields/SimpleFormField.dart';
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

  Future<void> submit(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(SimpleFormField), text);
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
  }

  testWidgets("name_IS_UPDATED_WHEN_Contact_IS_Updated", (tester) async {
    Contact contact = Contact();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return contact.updateContact(value!);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "Example");
    expect(contact.name, "Example");
  });

  testWidgets("name_IS_UPDATED_WHEN_Contact_IS_Updated", (tester) async {
    Contact contact = Contact();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return contact.updateContact(value!);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "");
    expect(contact.name, "");
  });



}
