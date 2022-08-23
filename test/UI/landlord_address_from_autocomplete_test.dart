import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordAddressForm.dart';

import '../test_case_builder.dart';

void main() {

  LandlordAddressForm getLandlordAddressForm() {
    return LandlordAddressForm(formKey: GlobalKey<FormState>(), landlordAddress: LandlordAddress(), );
  }

  testWidgets("Auto complete address fills street number on selected address", (tester) async {

    LandlordAddressForm form  = getLandlordAddressForm();
    form.testAddAddressToStream([{
"primary": '123 Queen Street West',
"secondary": 'Toronto, ON, Canada',
"placesId": 'ChIJoZ8Hus00K4gRfgPGjqVFR5w'

}]);
    
    
    await TestCaseBuilder(tester)
        .loadPage(form)
        .then(((value) => value.tapButton("123 Queen Street West")));

    find.text("123 Queen Street West").evaluate().forEach((element) => print(element),);
    expect(find.text("Please enter a street number."), findsNothing);
  });
}