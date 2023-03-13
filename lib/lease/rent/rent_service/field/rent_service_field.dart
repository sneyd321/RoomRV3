import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/field.dart';
import 'package:notification_app/lease/rent/rent_service/rent_service_error_key.dart';

class RentServiceField extends Field {
  @override
  void setErrorKey() {
    errorKey = RentServiceErrorKey.rentServiceName;
  }

  @override
  void setIcon() {
    icon = Icons.home_repair_service;
  }

  @override
  void setLabel() {
    label = "Rent Service";
  }


  
}