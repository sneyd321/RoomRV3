import 'package:flutter/material.dart';
import 'package:notification_app/bloc/list/card/card_template.dart';
import 'package:notification_app/lease/rental_address/parking_description/card/parking_description_card.dart';
import 'package:notification_app/lease/rental_address/parking_description/parking_description_bloc.dart';
import 'package:notification_app/lease/rental_address/parking_description/field/parking_description_field.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/list/list_container.dart';
import 'package:notification_app/lease/rental_address/rental_address_error_key.dart';

class ParkingDescriptionList extends ListContainer {
  @override
  CardTemplate getCard(
      BuildContext context, int index, Animation<double> animation) {
    return ParkingDescriptionCard(
      item: bloc.getList(errorKey).elementAt(index),
      onUpdate: (parkingDescription) {
        updateItem(parkingDescription, index);
      },
      onRemove: () {
        removeItem(index);
      },
      index: index,
    );
  }

  @override
  void setErrorKey() {
    errorKey = RentalAddressErrorKey.parkingDescriptions;
  }

  @override
  void setLabel() {
    label = "Add Description";
  }

  @override
  void setSelectionErrorKey() {
    selectionErrorKey = RentalAddressErrorKey.parkingDescription;
  }

  @override
  void setFormBuilder() {
    final ParkingDescriptionBloc parkingDescriptionBloc =
        ParkingDescriptionBloc();
    formBuilder =
        FormBuilder(parkingDescriptionBloc).add(ParkingDescriptionField());
  }
}
