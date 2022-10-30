
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/tenancy_terms.dart';
import 'package:notification_app/pages/add_lease_pages/add_tenancy_terms_page.dart';

import '../test_case_builder.dart';

void main() {

  AddTenancyTermsPage getAddTenancyTermsPage() {
    return AddTenancyTermsPage(onNext: (x){}, onBack: (c) {}, lease: Lease());
  }

  testWidgets("Validate rent paid on is first", (tester) async {
    await TestCaseBuilder(tester).loadPage(getAddTenancyTermsPage());
    Iterable<Element> elements = find.text("First").evaluate();
    print(elements);
  });
}