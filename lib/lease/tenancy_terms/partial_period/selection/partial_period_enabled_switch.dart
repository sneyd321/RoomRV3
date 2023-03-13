import 'package:flutter/material.dart';
import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/form_builder/form_container.dart';
import 'package:notification_app/bloc/helper/bottom_sheet_helper.dart';
import 'package:notification_app/lease/tenancy_terms/partial_period/field/partial_period_amount_field.dart';
import 'package:notification_app/lease/tenancy_terms/partial_period/partial_period_error_key.dart';

class PartialPeriodEnabledSwitch extends StatelessWidget {
  final String positiveOption;
  final String negativeOption;
  final bool value;
  final Bloc bloc;
  const PartialPeriodEnabledSwitch(
      {Key? key,
      required this.positiveOption,
      required this.negativeOption,
      required this.value,
      required this.bloc})
      : super(key: key);

  FormBuilder getFormBuilder(Bloc bloc) => FormBuilder(bloc)
      .addHint(
          "Discount on rent for the first month. Ex. Tenant moves in half way through the month")
      .add(PartialPeriodAmountField(top: 8));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: bloc.getSelectionValue(PartialPeriodErrorKey.isEnabled),
            title: Text(bloc.getSelectionValue(PartialPeriodErrorKey.isEnabled)
                ? positiveOption
                : negativeOption),
            onChanged: (value) {
              if (value) {
                BottomSheetHelper(FormContainer(
                        onUpdate: () {
                          bloc.setSelectionChange(
                              true, PartialPeriodErrorKey.isEnabled);
                        },
                        formBuilder: getFormBuilder(bloc),
                        buttonText: "Add Partial Period"))
                    .show(context);
                return;
              }
              bloc.setSelectionChange(false, PartialPeriodErrorKey.isEnabled);
            }),
        Visibility(
          visible: bloc.getSelectionValue(PartialPeriodErrorKey.isEnabled),
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.money),
                title: Text(
                    "\$${bloc.getFieldValue(PartialPeriodErrorKey.partialPeriodAmount)} due on ${bloc.getFieldValue(PartialPeriodErrorKey.partialPeriodDueDate)}"),
                subtitle: Text(
                    "From ${bloc.getFieldValue(PartialPeriodErrorKey.partialPeriodStartDate)} to ${bloc.getFieldValue(PartialPeriodErrorKey.partialPeriodEndDate)}"),
                trailing:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
