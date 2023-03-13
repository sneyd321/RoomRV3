import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/number_field.dart';
import 'package:notification_app/lease/rent/rent_error_key.dart';

class BaseRentField extends NumberField {
  BaseRentField(
      {double? top, double? left, double? right, double? bottom, double? width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);
  @override
  void setErrorKey() {
    errorKey = RentErrorKey.baseRent;
  }

  @override
  void setIcon() {
    icon = Icons.monetization_on;
  }

  @override
  void setLabel() {
    label = "Base Rent";
  }
}
