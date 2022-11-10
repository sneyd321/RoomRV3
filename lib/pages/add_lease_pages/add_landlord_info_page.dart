import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordInfoForm.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';

class AddLandlordInfoPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddLandlordInfoPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddLandlordInfoPage> createState() => _AddLandlordInfoPageState();
}

class _AddLandlordInfoPageState extends State<AddLandlordInfoPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onNext(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.lease.rent.setRentMadePayableTo(widget.lease.landlordInfo.fullName);
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
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [ LandlordInfoForm(
              landlordInfo: widget.lease.landlordInfo,
              formKey: formKey,
            ),
      ]),
        ),
        TwoColumnRow(
            left: SecondaryButton(Icons.chevron_left, "Back", onBack),
            right: PrimaryButton(Icons.chevron_right, "Next", onNext))
      ],
    );
  }
}
