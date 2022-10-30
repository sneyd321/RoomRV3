import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/TenancyTermsForm.dart';
import 'package:notification_app/widgets/mutations/tenancy_terms_mutation.dart';

class UpdateTenancyTermsPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onUpdate;
  const UpdateTenancyTermsPage(
      {Key? key,
      required this.onUpdate,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateTenancyTermsPage> createState() => _UpdateTenancyTermsPageState();
}

class _UpdateTenancyTermsPageState extends State<UpdateTenancyTermsPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onUpdateCallback(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.onUpdate(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: TenancyTermsForm(
            tenancyTerms: widget.lease.tenancyTerms,
            formKey: formKey,
          ),
        )),
        UpdateTenancyTermsMutation(formKey: formKey, lease: widget.lease,)
      ],
    );
  }
}
