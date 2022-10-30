import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordAddressForm.dart';

import '../../widgets/mutations/landlord_address_mutation.dart';

class UpdateLandlordAddressPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onUpdate;
  const UpdateLandlordAddressPage(
      {Key? key,
      required this.onUpdate,
      required this.lease})
      : super(key: key);

  

  @override
  State<UpdateLandlordAddressPage> createState() => _UpdateLandlordAddressPageState();
}

class _UpdateLandlordAddressPageState extends State<UpdateLandlordAddressPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  void onUpdate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.onUpdate(context);
    }
    else {
       scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(), children: [
          LandlordAddressForm(
            landlordAddress: widget.lease.landlordAddress,
            formKey: formKey,
          ),
        ])),
        UpdateLandlordInfoMutation(
          formKey: formKey,
          lease: widget.lease,
          onComplete: ((context, result) {}),
        )
      ],
    );
  }
}
