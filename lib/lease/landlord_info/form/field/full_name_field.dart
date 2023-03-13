import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/field.dart';
import 'package:notification_app/lease/landlord_info/landlord_info_error_key.dart';

class FullNameField extends Field {
  @override
  void setErrorKey() {
    errorKey = LandlordInfoErrorKey.fullName;
  }

  @override
  void setIcon() {
    icon = Icons.account_circle;
  }

  @override
  void setLabel() {
    label = "Full Name";
  }
}
