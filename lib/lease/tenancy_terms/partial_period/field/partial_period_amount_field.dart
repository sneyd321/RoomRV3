import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/number_field.dart';
import 'package:notification_app/lease/tenancy_terms/partial_period/partial_period_error_key.dart';

class PartialPeriodAmountField extends NumberField {
  PartialPeriodAmountField(
      {double? top, double? left, double? right, double? bottom, double? width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);
  @override
  void setErrorKey() {
    errorKey = PartialPeriodErrorKey.partialPeriodAmount;
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