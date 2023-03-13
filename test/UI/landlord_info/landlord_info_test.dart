import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/bloc_card/Listviews/animated_list_factory.dart';

import '../test.dart';


void main() {

  AnimatedListSelection selection = AnimatedListSelection.emails;
  String name = "asdf";
  String amount = "";
  String error = "Emails";

  testWidgets("List_IS_UPDATED_WHEN_List_IS_Added",
      (widgetTester) async {
    Test test = Test(widgetTester);
    await test.add(selection, name: name, amount: amount);
    expect(find.text(name), findsOneWidget);
  });

  testWidgets("List_IS_UPDATED_WHEN_List_of_Email_IS_Removed",
      (widgetTester) async {
      Test test = Test(widgetTester);
    await test.remove(selection, name: name, amount: amount);
    expect(find.text(name), findsNothing);
  });

  testWidgets("List_IS_UPDATED_WHEN_List_IS_Edited",
      (widgetTester) async {
      Test test = Test(widgetTester);
    await test.edit(selection, "fdsa", name: name, amount: amount);
    expect(find.text("fdsa"), findsOneWidget);
  });

  testWidgets("Resource_already_exists_IS_RETURNED_WHEN_List_IS_Error-Resource_Already_Exists",
      (widgetTester) async {
      Test test = Test(widgetTester);
    await test.resourceAlreadyExists(selection, error, name);
    expect(find.text("Error $name already exists."), findsOneWidget);
  });


}
  /*
  testWidgets("fullName_IS_UPDATED_WHEN_LandlordInfo_IS_Updated",
      (tester) async {
    LandlordInfo landlordInfo = LandlordInfo();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return landlordInfo.updateFullName(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "Example");
    expect(landlordInfo.fullName, "Example");
  });

  testWidgets("contactInfo_IS_UPDATED_WHEN_LandlordInfo_IS_Updated",
      (tester) async {
    LandlordInfo landlordInfo = LandlordInfo();
    landlordInfo.updateContactInfo(true);
    Widget formField = CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: landlordInfo.receiveDocumentsByEmail,
        title: const Text("If yes, provide information"),
        onChanged: (value) {
          landlordInfo.updateContactInfo(value!);
        });
    await tester.pumpWidget(getForm(formField));
    await tester.tap(find.text("If yes, provide information"));
    await tester.pump();
    expect(landlordInfo.contactInfo, false);
  });

  testWidgets("List_of_Contact_IS_UPDATED_WHEN_Contact_IS_Added",
      (tester) async {
    LandlordInfo landlordInfo = LandlordInfo();
    await tester.pumpWidget(getForm(ContactsList(landlordInfo: landlordInfo)));
    await addItemToList(tester, "asdf");
    expect(find.byType(ContactCard), findsOneWidget);
  });

  testWidgets("List_of_Contact_IS_UPDATED_WHEN_Contact_IS_Removed",
      (tester) async {
    LandlordInfo landlordInfo = LandlordInfo();
    await tester.pumpWidget(getForm(ContactsList(landlordInfo: landlordInfo)));
    await addItemToList(tester, "asdf");
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(find.byType(ContactCard), findsNothing);
  });

  testWidgets("List_of_Email_IS_UPDATED_WHEN_Email_IS_Added", (tester) async {
    LandlordInfo landlordInfo = LandlordInfo();
    await tester.pumpWidget(getForm(EmailsList(landlordInfo: landlordInfo)));
    await addItemToList(tester, "asdf");
    expect(find.byType(EmailCard), findsOneWidget);
  });

  testWidgets("List_of_Email_IS_UPDATED_WHEN_Email_IS_Removed", (tester) async {
    LandlordInfo landlordInfo = LandlordInfo();
    await tester.pumpWidget(getForm(EmailsList(landlordInfo: landlordInfo)));
    await addItemToList(tester, "asdf");
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(find.byType(EmailCard), findsNothing);
  });

  testWidgets(
      "Please_enter_a_full_name_IS_RETURNED_WHEN_LandlordInfo_IS_Error-Invalid_Request",
      (tester) async {
    LandlordInfo landlordInfo = LandlordInfo();
    Widget formField = SimpleFormField(
      label: "label",
      icon: Icons.abc,
      textEditingController: TextEditingController(),
      onSaved: (value) {},
      onValidate: (String? value) {
        return landlordInfo.updateFullName(value);
      },
    );
    await tester.pumpWidget(getForm(formField));
    await tester.enterText(find.byType(SimpleFormField), "");
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
    expect(find.text("Please enter a full name."), findsOneWidget);
  });

  testWidgets(
      "Email_is_already_added_IS_RETURNED_WHEN_List_of_Email_IS_Error-Resource_Exists",
      (tester) async {
    LandlordInfo landlordInfo = LandlordInfo();
    await tester.pumpWidget(getForm(EmailsList(landlordInfo: landlordInfo)));
    await addItemToList(tester, "asdf");
    await addItemToList(tester, "asdf");
    expect(find.textContaining("Error asdf already exists."), findsOneWidget);
  });

  testWidgets("Email_IS_REMOVED_WHEN_List_of_Email_IS_Error-Resource_Exists",
      (tester) async {
    LandlordInfo landlordInfo = LandlordInfo();
    await tester.pumpWidget(getForm(EmailsList(landlordInfo: landlordInfo)));
    await addItemToList(tester, "asdf");
    await addItemToList(tester, "asdf");
    expect(landlordInfo.emails.length, 1);
  });

  testWidgets(
      "Contact_information_is_already_added_IS_RETURNED_WHEN_List_of_Contact_IS_Error-Resource_Exists",
      (tester) async {
    LandlordInfo landlordInfo = LandlordInfo();
    await tester.pumpWidget(getForm(ContactsList(landlordInfo: landlordInfo)));
    await addItemToList(tester, "asdf");
    await addItemToList(tester, "asdf");
    expect(find.textContaining("Error asdf already exists."), findsOneWidget);
  });

  testWidgets(
      "Contact_IS_REMOVED_WHEN_List_of_Contact_IS_Error-Resource_Already_Exists",
      (tester) async {
    LandlordInfo landlordInfo = LandlordInfo();
    await tester.pumpWidget(getForm(ContactsList(landlordInfo: landlordInfo)));
    await addItemToList(tester, "asdf");
    await addItemToList(tester, "asdf");
    expect(landlordInfo.contacts.length, 1);
  });
}
*/
