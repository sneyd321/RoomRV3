import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/pages/add_lease_pages/add_landlord_info_page.dart';

import '../test_case_builder.dart';

void main() {
  Widget getLandlordInfoPage() {
    return AddLandlordInfoPage(
      lease: Lease(),
      onBack: (context) {},
      onNext: (context) {},
    );
  }

  testWidgets("Landlord info page returns empty text error message",
      (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getLandlordInfoPage())
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a name."), findsOneWidget);
  });

  testWidgets("Landlord info recieve documents visibility flag is working",
      (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getLandlordInfoPage())
        .then((value) => value.tapButton("If yes, provide email address"));
    expect(find.text("No Emails"), findsNothing);
  });

  testWidgets("Landlord info adds email to list", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getLandlordInfoPage())
        .then((value) => value.tapButton("Add Email"))
        .then((value) => value.enterText("Email", "a@s.com"))
        .then((value) => value.tapButton("Save"))
        .then((value) => value.tapButton("Add Email"))
        .then((value) => value.enterText("Email", "a@s.com"))
        .then((value) => value.tapButton("Save"));

    expect(find.text("a@s.com"), findsNWidgets(2));
  });

  testWidgets("Landlord info removes email from list", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getLandlordInfoPage())
        .then((value) => value.tapButton("Add Email"))
        .then((value) => value.enterText("Email", "a@s.com"))
        .then((value) => value.tapButton("Save"))
        .then((value) => value.tapCloseIcon());
    expect(find.text("No Contacts"), findsOneWidget);
  });

  testWidgets("Landlord info contact info visibility flag is working",
      (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getLandlordInfoPage())
        .then((value) => value.tapButton("If yes, provide information"));
    expect(find.text("No Contacts"), findsNothing);
  });

  testWidgets("Landlord info adds contact to list", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getLandlordInfoPage())
        .then((value) => value.tapButton("Add Contact"))
        .then((value) => value.enterText("Name", "4168186015"))
        .then((value) => value.tapButton("Save"));
    expect(find.text("4168186015"), findsOneWidget);
  });

  testWidgets("Landlord info removes contact from list", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getLandlordInfoPage())
        .then((builder) => builder.tapButton("Add Contact"))
        .then((builder) => builder.enterText("Name", "a@s.com"))
        .then((builder) => builder.tapButton("Save"))
        .then((builder) => builder.tapCloseIcon());
    expect(find.text("No Contacts"), findsOneWidget);
  });
}
