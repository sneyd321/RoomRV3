import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/pages/add_lease_pages/add_landlord_address_page.dart';

import '../test_case_builder.dart';

void main() {
  Widget getAddLandlordAddressPage() {
    return AddLandlordAddressPage(
        onNext: (context) {}, onBack: (context) {}, lease: Lease());
  }

  testWidgets("Street number validation is working correctly", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a street number."), findsOneWidget);
  });

  testWidgets("Street number does not return validation on valid entry", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.enterText("Street Number", "3327"))
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a street number."), findsNothing);
  });

  testWidgets("Street name validation is working correctly", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a street name."), findsOneWidget);
  });

   testWidgets("Street name does not return validation on valid entry", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.enterText("Street Name", "Example St."))
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a street name."), findsNothing);
  });

  testWidgets("City validation is working correctly", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a city."), findsOneWidget);
  });

   testWidgets("City does not return validation on valid entry", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.enterText("City", "Oakville"))
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a city."), findsNothing);
  });

  testWidgets("Province validation is working correctly", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a province."), findsOneWidget);
  });

  testWidgets("Province does not return validation on valid entry", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.enterText("Province", "Ontario"))
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a province."), findsNothing);
  });

  testWidgets("Postal Code validation is working correctly", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a postal code."), findsOneWidget);
  });

  testWidgets("Postal Code validation is working correctly with invalid pattern", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.enterText("Postal Code", "fdsafdsafdsa"))
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a valid postal code."), findsOneWidget);
  });

  testWidgets("Postal Code validation is working correctly with valid pattern", (tester) async {
    await TestCaseBuilder(tester)
    .loadPage(getAddLandlordAddressPage())
    .then((value) => value.enterText("Postal Code", "L6L 0E1"))
    .then((value) => value.tapButton("Next"),);
    expect(find.text("Please enter a valid postal code."), findsNothing);
  });

  testWidgets("Unit number validation is working correctly", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a unit number"), findsNothing);
  });

  testWidgets("P.O. Box validation is working correctly", (tester) async {
    await TestCaseBuilder(tester)
        .loadPage(getAddLandlordAddressPage())
        .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter a P.O. Box"), findsNothing);
  });



}
