import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordAddressForm.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';

class AddLandlordAddressPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddLandlordAddressPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  

  @override
  State<AddLandlordAddressPage> createState() => _AddLandlordAddressPageState();
}

class _AddLandlordAddressPageState extends State<AddLandlordAddressPage> {
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
              physics: const BouncingScrollPhysics(), children: [
          LandlordAddressForm(
            landlordAddress: widget.lease.landlordAddress,
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
