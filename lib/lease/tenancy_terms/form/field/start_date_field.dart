import 'package:notification_app/bloc/fields/date_field.dart';
import 'package:notification_app/lease/tenancy_terms/tenancy_terms_error_key.dart';

class StartDateField extends DateField {
  StartDateField({top, left, right, bottom, width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  void setErrorKey() {
    errorKey = TenancyTermsErrorKey.startDate;
  }

  @override
  void setLabel() {
    label = "Start Date";
  }
}
