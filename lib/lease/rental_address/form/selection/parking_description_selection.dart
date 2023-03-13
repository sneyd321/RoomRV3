
import 'package:notification_app/lease/rental_address/rental_address_error_key.dart';
import 'package:notification_app/bloc/selection/selection.dart';

class ParkingDescriptionSelection extends Selection {
  ParkingDescriptionSelection() : super();

  @override
  void setErrorKey() {
    errorKey = RentalAddressErrorKey.parkingDescription;
  }

  @override
  void setNegativeOption() {
    negativeOption = "No, this unit does not have parking";
  }

  @override
  void setPositiveOption() {
    positiveOption = "Yes, this unit has parking spaces";
  }



}