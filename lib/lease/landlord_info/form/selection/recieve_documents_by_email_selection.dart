import 'package:notification_app/lease/landlord_info/landlord_info_error_key.dart';
import 'package:notification_app/bloc/selection/selection.dart';

class ReceiveDocumentsByEmailSelection extends Selection {
  

  @override
  void setErrorKey() {
    errorKey = LandlordInfoErrorKey.receiveDocumentsByEmail;
  }
  
  @override
  void setNegativeOption() {
    negativeOption = "No, don't recieve notices and documents by email";
  }
  
  @override
  void setPositiveOption() {
    positiveOption = "Yes, recieve notices and documents by email";
  }
}
