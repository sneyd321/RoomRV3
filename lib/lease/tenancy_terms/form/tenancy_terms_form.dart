import 'package:flutter/material.dart';
import 'package:notification_app/lease/tenancy_terms/form/field/start_date_field.dart';
import 'package:notification_app/lease/tenancy_terms/form/selection/payment_period_selection.dart';
import 'package:notification_app/lease/tenancy_terms/form/selection/rent_due_date_selection.dart';
import 'package:notification_app/lease/tenancy_terms/form/selection/rental_period_selection.dart';
import 'package:notification_app/lease/tenancy_terms/partial_period/selection/partial_period_enabled_selection.dart';
import 'package:notification_app/lease/tenancy_terms/tenancy_terms_bloc.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/form_builder/form_container.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class TenancyTermsForm extends StatefulWidget {
  final Lease lease;
  final Function(TenancyTerms tenancyTerms) onUpdate;

  const TenancyTermsForm(
      {Key? key, required this.lease, required this.onUpdate})
      : super(key: key);

  @override
  State<TenancyTermsForm> createState() => _TenancyTermsFormState();
}

class _TenancyTermsFormState extends State<TenancyTermsForm>
    with TickerProviderStateMixin {
  late FormBuilder formBuilder;

  @override
  void initState() {
    super.initState();
    TenancyTermsBloc bloc = TenancyTermsBloc.fromLease(widget.lease);
    double width = WidgetsBinding.instance.window.physicalSize.width;
    double halfWidth = width / 2;
    formBuilder = FormBuilder(bloc, tickerProvider: this)
        .addText("Tenancy starts on:",
            left: 8,
            top: 8,
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
        .add(StartDateField(left: 8, width: halfWidth))
        .addText("This tenancy agreement is for:",
            left: 8,
            top: 8,
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
        .add(RentalPeriodSelection())
        .addText("Rent is paid on:",
            left: 8,
            top: 8,
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
        .add(RentDueDateSelection())
        .addText("Of each:",
            left: 8,
            top: 8,
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
        .add(PaymentPeriodSelection())
        .add(PartialPeriodEnabledSelection());
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      onUpdate: () {
        widget.onUpdate(formBuilder.bloc.getData());
      },
      formBuilder: formBuilder,
      buttonText: 'Update Tenancy Terms',
    );
  }
}
