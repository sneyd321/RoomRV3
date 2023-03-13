import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/bloc_card/Listviews/animated_list_factory.dart';

import 'test.dart';

void main() {

  AnimatedListSelection selection = AnimatedListSelection.contacts;
  String name = "asdf";
  String amount = "";
  String error = "Contacts";

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


