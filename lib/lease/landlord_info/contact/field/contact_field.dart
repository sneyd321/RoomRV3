import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/field.dart';
import 'package:notification_app/lease/landlord_info/contact/contact_error_key.dart';

class ContactField extends Field {
  @override
  void setErrorKey() {
    errorKey = ContactErrorKey.contactName;
  }

  @override
  void setIcon() {
    icon = Icons.phone;
  }

  @override
  void setLabel() {
    label = "Contact";
  }
  



}