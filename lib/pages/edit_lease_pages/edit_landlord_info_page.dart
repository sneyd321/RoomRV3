import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordInfoForm.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';

class EditLandlordInfoPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onUpdate;
  const EditLandlordInfoPage(
      {Key? key,
      required this.onUpdate,
      required this.lease})
      : super(key: key);

  @override
  State<EditLandlordInfoPage> createState() => _EditLandlordInfoPageState();
}

class _EditLandlordInfoPageState extends State<EditLandlordInfoPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onUpdate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.lease.rent
          .setRentMadePayableTo(widget.lease.landlordInfo.fullName);
      widget.onUpdate(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(physics: const BouncingScrollPhysics(), children: [
            LandlordInfoForm(
              landlordInfo: widget.lease.landlordInfo,
              formKey: formKey,
            ),
          ]),
        ),
        PrimaryButton(Icons.upload, "Update", onUpdate)
      ],
    );
  }
}
