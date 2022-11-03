import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestCaseBuilder {
  WidgetTester tester;

  TestCaseBuilder(this.tester);

  Future<TestCaseBuilder> tapButton(String name, {bool scroll = true}) async {
    if (scroll) {
       await scrollToPosition(name);
    }
    await tester.tap(find.text(name, skipOffstage: false));
    await tester.pumpAndSettle();
    return this;
  }

  Future<TestCaseBuilder> loadPage(Widget widget) async {
    await tester.pumpWidget(
        MaterialApp(home: Scaffold(appBar: AppBar(), body: (widget))));
    return this;
  }

  Future<TestCaseBuilder> loadPageWithDuration(Widget widget, Duration duration) async {
    await tester.pumpWidget(
        MaterialApp(home: Scaffold(appBar: AppBar(), body: (widget))), duration);
    return this;
  }

  Future<TestCaseBuilder> scrollToPosition(String text) async {
    await tester.scrollUntilVisible(find.text(text), 500.0,
        scrollable: find.byType(Scrollable).first);
    await tester.pump();
    return this;
  }

  Future<TestCaseBuilder> enterText(String label, String withText) async {
    Iterable<Element> elements = find.byType(TextField).evaluate();
    for (int i = 0; i < elements.length; i++) {
      if (elements.elementAt(i).toString().contains('labelText: "$label"')) {
        await tester.scrollUntilVisible(
            find.byWidget(elements.elementAt(i).widget), 500.0,
            scrollable: find.byType(Scrollable).first);
        await tester.pump();
        await tester.enterText(
            find.byWidget(elements.elementAt(i).widget), withText);
        await tester.pump();
      }
    }
    return this;
  }

  Future<TestCaseBuilder> tapCloseIcon() async {
    await tester.tap(find.byIcon(Icons.close).first);
    await tester.pumpAndSettle();
    return this;
  }
}
