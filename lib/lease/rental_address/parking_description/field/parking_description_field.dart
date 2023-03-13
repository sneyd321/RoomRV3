import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/field.dart';
import 'package:notification_app/lease/rental_address/parking_description/parking_description_bloc.dart';

class ParkingDescriptionField extends Field {
  ParkingDescriptionField({top, left, right, bottom, width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  void setErrorKey() {
    errorKey = ParkingDescriptionErrorKey.parkingDescriptionName;
  }

  @override
  void setIcon() {
    icon = Icons.description;
  }

  @override
  void setLabel() {
    label = "Parking Description";
  }
}
