import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/field.dart';
import 'package:notification_app/lease/landlord_info/email/email_error_key.dart';


class EmailField extends Field {
  @override
  void setErrorKey() {
    errorKey = EmailErrorKey.emailName;
  }

  @override
  void setIcon() {
    icon = Icons.email;
  }

  @override
  void setLabel() {
    label = "Email";
  }
  

 
  
}
