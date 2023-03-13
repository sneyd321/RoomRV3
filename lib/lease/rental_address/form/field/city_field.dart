import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/field.dart';
import 'package:notification_app/lease/rental_address/rental_address_error_key.dart';

class CityField extends Field {
  CityField({top, left, right, bottom, width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  void setErrorKey() {
    errorKey = RentalAddressErrorKey.city;
  }

  @override
  void setIcon() {
    icon = Icons.location_city;
  }

  @override
  void setLabel() {
    label = "City";
  }
}
