import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/pages/add_lease_pages/add_rent_page.dart';

import '../test_case_builder.dart';

void main() {

  AddRentPage getAddRentPage() {
    return AddRentPage(onNext: (c){}, onBack: (c){}, lease: Lease());
  }
  AddRentPage getAddRentPageWithLease(Lease lease) {
    return AddRentPage(onNext: (c){}, onBack: (c){}, lease: lease);
  }
  testWidgets("Base Rent validation is working correctly", (tester) async {
    await TestCaseBuilder(tester)
    .loadPage(getAddRentPage())
    .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter the base rent."), findsOneWidget);
  });

  testWidgets("Base Rent validation is working correctly with valid input", (tester) async {
    await TestCaseBuilder(tester)
    .loadPage(getAddRentPage())
    .then((value) => value.enterText("Base Rent", "2000"))
    .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter the base rent."), findsNothing);
  });

  testWidgets("Base Rent updates total lawful rent on text change", (tester) async {
    await TestCaseBuilder(tester)
    .loadPage(getAddRentPage())
    .then((value) => value.enterText("Base Rent", "2000"));
    expect(find.text("Total Lawful Rent: \$2,000.00"), findsOneWidget);
  });

  testWidgets("Rent made payable to is working correctly", (tester) async {
    await TestCaseBuilder(tester)
    .loadPage(getAddRentPage())
    .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter who rent is made payable to."), findsOneWidget);
  });

  testWidgets("Rent Made payable is loaded from lease", (tester) async {
    Lease lease = Lease();
    lease.rent.rentMadePayableTo = "Ryan Sneyd";
    await TestCaseBuilder(tester)
    .loadPage(getAddRentPageWithLease(lease))
    .then((value) => value.tapButton("Next"));
    expect(find.text("Please enter who rent is made payable to."), findsNothing);
  });

  testWidgets("Adding rent service updates list", (tester) async {
    await TestCaseBuilder(tester)
    .loadPage(getAddRentPage())
    .then((value) => value.tapButton("Add Service"))
    .then((value) => value.enterText("Name", 'Parking'))
    .then((value) => value.enterText("Amount", "200"))
    .then((value) => value.tapButton("Save"));
    expect(find.text("Parking"), findsOneWidget);
  });

  testWidgets("Adding rent service updates total lawful rent", (tester) async {
    await TestCaseBuilder(tester)
    .loadPage(getAddRentPage())
    .then((value) => value.tapButton("Add Service"))
    .then((value) => value.enterText("Name", 'Parking'))
    .then((value) => value.enterText("Amount", "200"))
    .then((value) => value.tapButton("Save"));
    expect(find.text("Total Lawful Rent: \$200.00"), findsOneWidget);
  });


  testWidgets("Removing rent service works as expected", (tester) async {
    await TestCaseBuilder(tester)
    .loadPage(getAddRentPage())
    .then((value) => value.tapButton("Add Service"))
    .then((value) => value.enterText("Name", 'Parking'))
    .then((value) => value.enterText("Amount", "200"))
    .then((value) => value.tapButton("Save"))
    .then((value) => value.tapCloseIcon());
    expect(find.text("No Services"), findsOneWidget);
  });

  testWidgets("Removing rent service updates total lawful rent", (tester) async {
    await TestCaseBuilder(tester)
    .loadPage(getAddRentPage())
    .then((value) => value.tapButton("Add Service"))
    .then((value) => value.enterText("Name", 'Parking'))
    .then((value) => value.enterText("Amount", "200"))
    .then((value) => value.tapButton("Save"))
    .then((value) => value.tapCloseIcon());
    expect(find.text("Total Lawful Rent: \$0.00"), findsOneWidget);
  });

  testWidgets("Adding payment option updates list", (tester) async {
    await TestCaseBuilder(tester)
    .loadPage(getAddRentPage())
    .then((value) => value.tapButton("Add Payment"))
    .then((value) => value.enterText("Name", 'Example'))
    .then((value) => value.tapButton("Save"));
    expect(find.text("Example"), findsOneWidget);
  });

  testWidgets("Remove payment option updates list", (tester) async {
    await TestCaseBuilder(tester)
    .loadPage(getAddRentPage())
    .then((value) => value.tapCloseIcon(),);
    expect(find.text("E Transfer"), findsNothing);
  });




}