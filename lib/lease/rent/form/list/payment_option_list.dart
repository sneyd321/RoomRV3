import 'package:flutter/cupertino.dart';
import 'package:notification_app/bloc/list/card/card_template.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/list/list_container.dart';
import 'package:notification_app/lease/rent/payment_option/card/payment_option_card.dart';
import 'package:notification_app/lease/rent/payment_option/field/payment_option_field.dart';
import 'package:notification_app/lease/rent/payment_option/payment_option_bloc.dart';
import 'package:notification_app/lease/rent/rent_error_key.dart';

class PaymentOptionList extends ListContainer {
  @override
  CardTemplate getCard(
      BuildContext context, int index, Animation<double> animation) {
    return PaymentOptionCard(
        item: bloc.getList(errorKey).elementAt(index),
        index: index,
        onUpdate: (paymentOption) {
          updateItem(paymentOption, index);
        },
        onRemove: () {
          removeItem(index);
        });
  }

  @override
  void setErrorKey() {
    errorKey = RentErrorKey.paymentOptions;
  }

  @override
  void setLabel() {
    label = "Add Payment Option";
  }

  @override
  void setSelectionErrorKey() {
    selectionErrorKey = RentErrorKey.paymentOptions;
  }

  @override
  void setFormBuilder() {
    final PaymentOptionBloc paymentOptionBloc = PaymentOptionBloc();
    formBuilder = FormBuilder(paymentOptionBloc).add(PaymentOptionField());
  }
}
