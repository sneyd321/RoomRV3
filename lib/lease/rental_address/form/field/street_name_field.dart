import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/field.dart';
import 'package:notification_app/lease/rental_address/rental_address_error_key.dart';

class StreetNameField extends Field {
  StreetNameField({top, left, right, bottom, width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  void setErrorKey() {
    errorKey = RentalAddressErrorKey.streetName;
  }

  @override
  void setIcon() {
    icon = Icons.route_sharp;
  }

  @override
  void setLabel() {
    label = "Street Name";
  }
}
