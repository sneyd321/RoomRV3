import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/RentalAddressForm.dart';
import 'package:notification_app/widgets/mutations/rental_address_mutation.dart';

class UpdateRentalAddressPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onUpdate;
  const UpdateRentalAddressPage(
      {Key? key,
      required this.onUpdate,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateRentalAddressPage> createState() => _UpdateRentalAddressPageState();
}

class _UpdateRentalAddressPageState extends State<UpdateRentalAddressPage> {
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
          physics: const BouncingScrollPhysics(),
          children: [RentalAddressForm(
            rentalAddress: widget.lease.rentalAddress,
            formKey: formKey,
          ),
      ])),
        UpdateRentalAddressMutation(onComplete: ((context, rentalAddress) {}), formKey: formKey, lease: widget.lease)
      ],
    );
  }
}
