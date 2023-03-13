import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/number_field.dart';
import 'package:notification_app/lease/rent/rent_service/rent_service_error_key.dart';

class RentServiceAmountField extends NumberField {
  @override
  void setErrorKey() {
    errorKey = RentServiceErrorKey.rentServiceAmount;
  }

  @override
  void setIcon() {
    icon = Icons.monetization_on;
  }

  @override
  void setLabel() {
    label = "Amount";
  }



}