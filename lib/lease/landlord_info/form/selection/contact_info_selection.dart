
import 'package:notification_app/lease/landlord_info/landlord_info_error_key.dart';
import 'package:notification_app/bloc/selection/selection.dart';

class ContactInfoSelection extends Selection {
  @override
  void setErrorKey() {
    errorKey = LandlordInfoErrorKey.contactInfo;
  }
  
  @override
  void setNegativeOption() {
    negativeOption = "No, don't provide phone or email for emergencies and day to day communincation";
  }
  
  @override
  void setPositiveOption() {
    positiveOption = "Yes, provide phone or email for emergencies and day to day communincation";
  }
}
