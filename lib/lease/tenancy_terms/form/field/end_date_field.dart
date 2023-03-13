import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/date_field.dart';
import 'package:notification_app/lease/tenancy_terms/tenancy_terms_error_key.dart';

class EndDateField extends DateField {
  EndDateField({top, left, right, bottom, width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  void setErrorKey() {
    errorKey = TenancyTermsErrorKey.endDate;
  }

  @override
  void setIcon() {
    icon = Icons.date_range;
  }

  @override
  void setLabel() {
    label = "End Date";
  }
}
