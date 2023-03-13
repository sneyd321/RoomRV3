import 'package:notification_app/bloc/fields/date_field.dart';
import 'package:notification_app/lease/tenancy_terms/partial_period/partial_period_error_key.dart';

class PartialPeriodDueDateField extends DateField {

  PartialPeriodDueDateField({double? top, double? left, double? right, double? bottom, double? width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);
  @override
  void setErrorKey() {
    errorKey = PartialPeriodErrorKey.partialPeriodDueDate;
  }

  @override
  void setLabel() {
    label = "Due On";
  }


  
}