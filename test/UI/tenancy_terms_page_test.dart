import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/business_logic/tenancy_terms.dart';
import 'package:notification_app/widgets/Forms/Form/TenancyTermsForm.dart';


void main() {
  TenancyTermsForm getForm() {
    return TenancyTermsForm(
      tenancyTerms: TenancyTerms(),
      formKey: GlobalKey<FormState>(),
    );
  }

  Widget getApp(Widget widget) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(body: widget),
    ));
  }

  testWidgets("Rent_due_date_updates_to_first_when_payment_period_is_day",
      (tester) async {
    tester.ensureSemantics();
    await tester.pumpWidget(getApp(getForm()));
    await tester.tap(find.text("Second"));
    await tester.pump();
    await tester.tap(find.text("Day"));
    await tester.pump();

    expect(
        tester
            .getSemantics(find.text("First"))
            .getSemanticsData()
            .hasFlag(SemanticsFlag.hasCheckedState),
        true);
  });

  testWidgets("Start_date_is_filled_when_date_is_selected_on_calendar_picker",
      (tester) async {
    await tester.pumpWidget(getApp(getForm()));
    await tester.tap(find.byType(TextField).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text("1"));
    await tester.pump();

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    await tester.pump();

    DateTime now = DateTime.now();
    final firstDayInMonth = DateTime.utc(now.year, now.month, 1);
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    expect(find.text(formatter.format(firstDayInMonth)), findsOneWidget);
  });

  testWidgets("End_date_is_filled_when_date_is_selected_on_calendar_picker",
      (tester) async {
    await tester.pumpWidget(getApp(getForm()));
    await tester.tap(find.byType(TextField).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text("1"));
    await tester.pump();

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    await tester.pump();

    DateTime now = DateTime.now();
    final firstDayInMonth = DateTime.utc(now.year, now.month, 1);
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    expect(find.text(formatter.format(firstDayInMonth)), findsOneWidget);
  });




 



}
