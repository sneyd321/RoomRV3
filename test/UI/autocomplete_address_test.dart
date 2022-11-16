import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordAddressForm.dart';


void main() {

  LandlordAddressForm getLandlordAddressForm() {
    return LandlordAddressForm(
          formKey: GlobalKey<FormState>(),
          landlordAddress: LandlordAddress(),
          isTest: true,
        );
  }

  Widget getApp(Widget widget) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: widget
      ),
    ));
  }

  testWidgets("Autocomplete_address_displays_address_list_and_updates_fields_on_tap",
      (tester) async {
    LandlordAddressForm form = getLandlordAddressForm();
    await tester.pumpWidget(getApp(form));
    form.testAddAddressToStream([
      {
        "primary": '123 Queen Street West',
        "secondary": 'Toronto, ON, Canada',
        "placesId": 'ChIJoZ8Hus00K4gRfgPGjqVFR5w'
      }
    ]);
    await tester.pump();
  
    await tester.tap(find.text("123 Queen Street West"));
    await tester.pump();

    expect(find.textContaining("123"), findsOneWidget);
  });
}
