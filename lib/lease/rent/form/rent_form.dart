import 'package:flutter/material.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/form_builder/form_container.dart';
import 'package:notification_app/lease/rent/form/field/base_rent_feild.dart';
import 'package:notification_app/lease/rent/form/field/rent_made_payable_to.dart';
import 'package:notification_app/lease/rent/form/list/payment_option_list.dart';
import 'package:notification_app/lease/rent/form/list/rent_service_list.dart';
import 'package:notification_app/lease/rent/form/text/total_lawful_rent_text.dart';
import 'package:notification_app/lease/rent/rent_bloc.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class RentForm extends StatefulWidget {
  final Lease lease;
  final Function(Rent rent) onUpdate;

  const RentForm({
    Key? key,
    required this.lease,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<RentForm> createState() => _RentFormState();
}

class _RentFormState extends State<RentForm> with TickerProviderStateMixin {
  late FormBuilder formBuilder;

  @override
  void initState() {
    super.initState();
    RentBloc rentBloc = RentBloc.fromLease(widget.lease);
    double width = WidgetsBinding.instance.window.physicalSize.width;
    double halfWidth = width / 2;
    formBuilder = FormBuilder(rentBloc, tickerProvider: this)
        .addHint("The tenant will pay the following rent", left: 8, top: 8)
        .add(BaseRentField(top: 8, left: 8, right: 8, width: halfWidth))
        .add(RentMadePayableToField(left: 8, right: 8))
        .add(TotalLawfulRentText(
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            left: 8))
        .add(RentServiceList())
        .add(PaymentOptionList());
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      onUpdate: () {
        widget.onUpdate(formBuilder.bloc.getData());
      },
      formBuilder: formBuilder,
      buttonText: 'Update Rent',
    );
  }
}
