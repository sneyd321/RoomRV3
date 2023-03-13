import 'package:flutter/cupertino.dart';
import 'package:notification_app/bloc/list/card/card_template.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';

import 'package:notification_app/bloc/list/list_container.dart';
import 'package:notification_app/lease/rent/rent_error_key.dart';
import 'package:notification_app/lease/rent/rent_service/card/rent_service_card.dart';
import 'package:notification_app/lease/rent/rent_service/field/rent_service_amount_field.dart';
import 'package:notification_app/lease/rent/rent_service/field/rent_service_field.dart';
import 'package:notification_app/lease/rent/rent_service/rent_service_bloc.dart';

class RentServiceList extends ListContainer {
  @override
  CardTemplate getCard(
      BuildContext context, int index, Animation<double> animation) {
    return RentServiceCard(
      item: bloc.getList(errorKey).elementAt(index),
      index: index,
      onUpdate: (rentService) {
        updateItem(rentService, index);
      },
      onRemove: () {
        removeItem(index);
      },
    );
  }

  @override
  void setErrorKey() {
    errorKey = RentErrorKey.rentServices;
  }

  @override
  void setLabel() {
    label = "Add Service";
  }

  @override
  void setSelectionErrorKey() {
    selectionErrorKey = RentErrorKey.rentServices;
  }

  @override
  void setFormBuilder() {
    final RentServiceBloc rentServiceBloc = RentServiceBloc();
    formBuilder = FormBuilder(rentServiceBloc)
        .add(RentServiceField())
        .add(RentServiceAmountField());
  }
}
