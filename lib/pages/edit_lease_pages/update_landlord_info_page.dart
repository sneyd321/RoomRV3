import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordInfoForm.dart';
import 'package:notification_app/widgets/mutations/landlord_info_mutation.dart';

class UpdateLandlordInfoPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onUpdate;
  const UpdateLandlordInfoPage({
    Key? key,
    required this.onUpdate,
    required this.lease,
  }) : super(key: key);

  @override
  State<UpdateLandlordInfoPage> createState() => _UpdateLandlordInfoPageState();
}

class _UpdateLandlordInfoPageState extends State<UpdateLandlordInfoPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onUpdate(BuildContext context) {
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
          child: ListView(physics: const BouncingScrollPhysics(), children: [
            LandlordInfoForm(
              landlordInfo: widget.lease.landlordInfo,
              formKey: formKey,
            ),
          ]),
        ),
        UpdateLandlordAddressMutation(
          formKey: formKey,
          lease: widget.lease,
          onComplete: ((context, result) {}),
        ),
      ],
    );
  }
}
