
import 'package:notification_app/lease/rental_address/rental_address_error_key.dart';
import 'package:notification_app/bloc/selection/selection.dart';

class IsCondoSelection extends Selection {

  @override
  void setErrorKey() {
    errorKey = RentalAddressErrorKey.isCondo;
  }

  @override
  void setNegativeOption() {
    negativeOption = "No, this unit is not a condo";
  }

  @override
  void setPositiveOption() {
    positiveOption = "Yes, this unit is a condo";
  }
}