import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/RentalAddressForm.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';

class AddRentalAddressPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddRentalAddressPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddRentalAddressPage> createState() => _AddRentalAddressPageState();
}

class _AddRentalAddressPageState extends State<AddRentalAddressPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  void onNext(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.onNext(context);
    }
     else {
       scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                      );
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
              controller: scrollController,
          physics: const BouncingScrollPhysics(),
          children: [RentalAddressForm(
            rentalAddress: widget.lease.rentalAddress,
            formKey: formKey,
          ),
      ])),
        TwoColumnRow(
            left: SecondaryButton(Icons.chevron_left, "Back", onBack),
            right: PrimaryButton(Icons.chevron_right, "Next", onNext))
      ],
    );
  }
}
