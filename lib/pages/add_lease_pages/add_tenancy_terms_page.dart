import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/TenancyTermsForm.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';

class AddTenancyTermsPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddTenancyTermsPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddTenancyTermsPage> createState() => _AddTenancyTermsPageState();
}

class _AddTenancyTermsPageState extends State<AddTenancyTermsPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onNext(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.onNext(context);
    }
  }

  void onBack(BuildContext context) {
    widget.onBack(context);
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
        TwoColumnRow(
            left: SecondaryButton(Icons.chevron_left, "Back", onBack),
            right: PrimaryButton(Icons.chevron_right, "Next", onNext))
      ],
    );
  }
}
