import 'package:flutter/material.dart';
import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/bloc/helper/bottom_sheet_helper.dart';
import 'package:notification_app/bloc/list/card/card_template.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/form_builder/form_container.dart';
import 'package:notification_app/lease/rent/rent_service/field/rent_service_amount_field.dart';
import 'package:notification_app/lease/rent/rent_service/rent_service_bloc.dart';
import 'package:notification_app/lease/rent/rent_service/field/rent_service_field.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class RentServiceCard extends CardTemplate<RentService> {
  RentServiceCard(
      {required RentService item,
      required int index,
      required void Function(RentService t) onUpdate,
      required void Function() onRemove})
      : super(item: item, index: index, onUpdate: onUpdate, onRemove: onRemove);

  FormBuilder getNameFormBuilder(Bloc bloc) => FormBuilder(bloc).add(RentServiceField());
  FormBuilder getAmountFormBuilder(Bloc bloc) => FormBuilder(bloc)
                        .add(RentServiceAmountField());

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: ListTile(
        leading: const Icon(Icons.home_repair_service),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  final RentServiceBloc rentServiceBloc = RentServiceBloc();
                  BottomSheetHelper(FormContainer(
                    onUpdate: () {
                      onUpdate(rentServiceBloc.getData());
                    },
                    formBuilder: getNameFormBuilder(rentServiceBloc),
                    buttonText: 'Update Service Name',
                  )).show(context);
                },
                child: Text(item.name)),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  final RentServiceBloc rentServiceBloc = RentServiceBloc();
                  BottomSheetHelper(FormContainer(
                    onUpdate: () {
                      onUpdate(rentServiceBloc.getData());
                    },
                    formBuilder: getAmountFormBuilder(rentServiceBloc),
                    buttonText: 'Update Amount',
                  )).show(context);
                },
                child: Text("\$${item.amount}")),
          ],
        ),
        trailing:
            IconButton(icon: const Icon(Icons.close), onPressed: onRemove),
      ),
    );
  }
}
