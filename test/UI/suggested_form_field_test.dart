import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notification_app/widgets/FormFields/SuggestedFormField.dart';


void main() {
  Widget getForm() {
    return SuggestedFormField(
      label: "TEST",
      icon: Icons.abc,
      onSaved: (value) {},
      onValidate: (value) {},
      textEditingController: TextEditingController(),
      suggestedNames: const ["a", "b", "abc"],
    );
  }

  Widget getApp(Widget widget) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(body: widget),
    ));
  }

  testWidgets("Suggested_form_field_list_filters_recommended_results_while_typing",
      (tester) async {
    Widget formField = getForm();
    await tester.pumpWidget(getApp(formField));

    await tester.enterText(find.byType(TextField).first, "b");
    await tester.pump();


    expect(find.textContaining("a"), findsNothing);
  });

  testWidgets("Suggested_form_field_updates_on_item_selected",
      (tester) async {
    Widget formField = getForm();
    await tester.pumpWidget(getApp(formField));

    await tester.enterText(find.byType(TextField).first, "abc");
    await tester.pump();

    await tester.tap(find.text("abc").last);

    expect(find.textContaining("abc"), findsOneWidget);
  });


}
