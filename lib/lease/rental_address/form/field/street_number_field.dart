import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/field.dart';
import 'package:notification_app/lease/rental_address/rental_address_error_key.dart';

class StreetNumberField extends Field {
  StreetNumberField({top, left, right, bottom, width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  void setErrorKey() {
    errorKey = RentalAddressErrorKey.streetNumber;
  }

  @override
  void setIcon() {
    icon = Icons.numbers;
  }

  @override
  void setLabel() {
    label = "Street Number";
  }
}
