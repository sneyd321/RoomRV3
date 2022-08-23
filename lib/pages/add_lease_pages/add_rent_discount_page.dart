import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordAddressForm.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/RentDiscountsList.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/ServicesList.dart';

class AddRentDiscountPage extends StatefulWidget {
  final Lease lease;

  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddRentDiscountPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddRentDiscountPage> createState() => _AddRentDiscountPageState();
}

class _AddRentDiscountPageState extends State<AddRentDiscountPage> {
  String errorText = "";
  void onNextCallback(BuildContext context) {
      widget.onNext(context);
  }

  void onBackCallback(BuildContext context) {
    widget.onBack(context);
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
         TwoColumnRow(
            left: SecondaryButton(Icons.chevron_left, "Back", onBackCallback),
            right: PrimaryButton(Icons.chevron_right, "Next", onNextCallback))
      ],
    );
  }
}


