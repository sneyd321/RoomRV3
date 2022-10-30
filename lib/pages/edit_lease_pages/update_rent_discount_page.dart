import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/RentDiscountsList.dart';
import 'package:notification_app/widgets/mutations/rent_discount_mutation.dart';

class UpdateRentDiscountPage extends StatefulWidget {
  final Lease lease;

  final Function(BuildContext context) onUpdate;
  const UpdateRentDiscountPage(
      {Key? key,
      required this.onUpdate,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateRentDiscountPage> createState() => _UpdateRentDiscountPageState();
}

class _UpdateRentDiscountPageState extends State<UpdateRentDiscountPage> {
  String errorText = "";
  bool validate() {
      return true;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: RentDiscountsList(rentDiscounts: widget.lease.rentDiscounts)),
        Container(
          margin: const EdgeInsets.only(left: 8, bottom: 8),
          alignment: Alignment.centerLeft,
          child: Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 18),)),
         UpdateRentDiscountMutation(lease: widget.lease, onComplete: ((context, discounts) {
           
         }), validate: validate)
      ],
    );
  }
}


