import 'package:flutter/material.dart';
import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/bloc/helper/bottom_sheet_helper.dart';
import 'package:notification_app/bloc/list/card/card_template.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/form_builder/form_container.dart';
import 'package:notification_app/lease/rent/payment_option/field/payment_option_field.dart';
import 'package:notification_app/lease/rent/payment_option/payment_option_bloc.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class PaymentOptionCard extends CardTemplate<PaymentOption> {
  PaymentOptionCard(
      {required PaymentOption item,
      required int index,
      required void Function(PaymentOption t) onUpdate,
      required void Function() onRemove})
      : super(item: item, index: index, onUpdate: onUpdate, onRemove: onRemove);

  FormBuilder getFormBuilder(Bloc bloc) =>
      FormBuilder(bloc).add(PaymentOptionField());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.payment),
        title: GestureDetector(
            onTap: () {
              final PaymentOptionBloc paymentOptionBloc = PaymentOptionBloc();
              BottomSheetHelper(FormContainer(
                onUpdate: () {
                  onUpdate(paymentOptionBloc.getData());
                },
                formBuilder: getFormBuilder(paymentOptionBloc),
                buttonText: 'Update Payment Option',
              )).show(context);
            },
            child: Text(item.name)),
        trailing:
            IconButton(icon: const Icon(Icons.close), onPressed: onRemove),
      ),
    );
  }
}
