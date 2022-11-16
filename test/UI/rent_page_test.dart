import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/pages/add_lease_pages/add_rent_page.dart';


void main() {
  AddRentPage getAddRentPage() {
    return AddRentPage(onNext: (c) {}, onBack: (c) {}, lease: Lease());
  }

  Widget getApp(Widget widget) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(body: widget),
    ));
  }

  testWidgets("Total_rent_is_calculated_on_base_rent_update", (tester) async {
    await tester.pumpWidget(getApp(getAddRentPage()));
    await tester.enterText(find.byType(TextField).first, "2000");
    await tester.pump();
    expect(find.text("Total Lawful Rent: \$2,000.00"), findsOneWidget);
  });

  testWidgets("Sliver_list_can_be_added", (tester) async {
    await tester.pumpWidget(getApp(getAddRentPage()));

    await tester.tap(find.text("Add Service"));

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(2), "Example");
    await tester.pump();
    await tester.enterText(find.byType(TextField).at(3), "200");
    await tester.pump();
    await tester.tap(find.text("Save"));
    await tester.pumpAndSettle();
    await tester.pump();

    expect(find.text("Total Lawful Rent: \$200.00"), findsOneWidget);
  });

  testWidgets("Sliver_list_can_be_removed", (tester) async {
    await tester.pumpWidget(getApp(getAddRentPage()));

    await tester.tap(find.text("Add Service"));

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(2), "Example");
    await tester.pump();
    await tester.enterText(find.byType(TextField).at(3), "200");
    await tester.pump();
    await tester.tap(find.text("Save"));
    await tester.pumpAndSettle();
    await tester.pump();

    await tester.tap(find.byIcon(Icons.close).first);
    await tester.pump();
    expect(find.text("Total Lawful Rent: \$0.00"), findsOneWidget);
  });
}
