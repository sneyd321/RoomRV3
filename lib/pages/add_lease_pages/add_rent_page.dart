import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/deposit.dart';
import 'package:notification_app/business_logic/rent.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/CreateHouseRentForm.dart';
import 'package:notification_app/widgets/Forms/Form/RentForm.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';

class AddRentPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddRentPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddRentPage> createState() => _AddRentPageState();
}

class _AddRentPageState extends State<AddRentPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onNext(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.lease.rentDeposits.insert(0, RentDeposit(widget.lease.rent.baseRent));
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
          child: CreateHouseRentForm(
            rent: widget.lease.rent,
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
