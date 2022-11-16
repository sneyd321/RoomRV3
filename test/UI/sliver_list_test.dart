import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/DetailsList.dart';


void main() {
  Widget getSliverList() {
    List<String> items = ["detail"];
    return DetailsList(details: items);
  }

  Widget getApp(Widget widget) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(body: widget),
    ));
  }

   testWidgets(
      "Sliver_list_can_be_added",
      (tester) async {
    Widget list = getSliverList();
    await tester.pumpWidget(getApp(list));
    await tester.tap(find.text("Add Detail"));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, "Example");
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text("Example"), findsOneWidget);
  });

  testWidgets(
      "Sliver_list_can_be_removed",
      (tester) async {
    Widget list = getSliverList();
    await tester.pumpWidget(getApp(list));
    await tester.tap(find.byIcon(Icons.close).first);
    await tester.pump();
    expect(find.text("detail"), findsNothing);
  });
}
