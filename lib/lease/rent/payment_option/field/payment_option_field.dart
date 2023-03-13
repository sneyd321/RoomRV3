import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/field.dart';
import 'package:notification_app/lease/rent/payment_option/payment_option_error_key.dart';

class PaymentOptionField extends Field {

  @override
  void setErrorKey() {
    errorKey = PaymentOptionErrorKey.paymentOptionName;
  }

  @override
  void setIcon() {
    icon = Icons.payment;
  }

  @override
  void setLabel() {
    label = "Payment Option";
  }



}