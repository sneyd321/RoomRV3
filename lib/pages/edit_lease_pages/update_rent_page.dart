import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/deposit.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/RentForm.dart';
import 'package:notification_app/widgets/mutations/rent_mutation.dart';

class UpdateRentPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onUpdate;
  const UpdateRentPage(
      {Key? key,
      required this.onUpdate,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateRentPage> createState() => _UpdateRentPageState();
}

class _UpdateRentPageState extends State<UpdateRentPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onUpdate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.lease.rentDeposits.insert(0, RentDeposit(widget.lease.rent.baseRent));
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
          child: RentForm(
            rent: widget.lease.rent,
            formKey: formKey,
          ),
        )),
               UpdateRentMutation(formKey: formKey, lease: widget.lease)

      ],
    );
  }
}
