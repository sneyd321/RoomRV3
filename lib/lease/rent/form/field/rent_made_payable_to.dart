import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/field.dart';
import 'package:notification_app/lease/rent/rent_error_key.dart';

class RentMadePayableToField extends Field {
  RentMadePayableToField(
      {double? top, double? left, double? right, double? bottom, double? width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);
 
 
  @override
  void setErrorKey() {
    errorKey = RentErrorKey.rentMadePayableTo;
  }

  @override
  void setIcon() {
    icon = Icons.account_circle;
  }

  @override
  void setLabel() {
    label = "Rent Made Payable To";
  }
}
