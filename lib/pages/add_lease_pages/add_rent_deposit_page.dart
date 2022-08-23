import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/deposit.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/DepositsList.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/RentDiscountsList.dart';

class AddRentDepositPage extends StatefulWidget {
  final Lease lease;

  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddRentDepositPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddRentDepositPage> createState() => _AddRentDepositPageState();
}

class _AddRentDepositPageState extends State<AddRentDepositPage> {
  String errorText = "";
  void onNextCallback(BuildContext context) {
    errorText = "";
    List<String> serviceNames = widget.lease.rentDeposits.map<String>((Deposit rentDeposit) => rentDeposit.name).toList();
    List<String> differences = {"Rent Deposit", "Key Deposit", "Pet Damage Deposit", "Maintenance Ticket Deductable"}.difference(serviceNames.toSet()).toList();
    print(differences);
    if (differences.isEmpty) {
      setState(() {
        errorText = "";
      });
      widget.onNext(context);
      return;
    }
    for (String element in differences) {
      errorText += errorText.isEmpty ? element : ", $element"; 
      switch (element) {
        case "Rent Deposit":
          widget.lease.rentDeposits.insert(0, RentDeposit(widget.lease.rent.baseRent));
          continue;
        case "Key Deposit":
          widget.lease.rentDeposits.insert(1, KeyDeposit());
          continue;
        case "Pet Damage Deposit":
          widget.lease.rentDeposits.insert(2, PetDamageDeposit());
          continue;
        case "Maintenance Ticket Deductable":
          widget.lease.rentDeposits.insert(3, MaintenanceDeductableDeposit());
          continue;
       
      }
    }
    setState(() {
      errorText += " deposits(s) required";
    });
     
  }

  void onBackCallback(BuildContext context) {
    widget.onBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: DepositsList(deposits: widget.lease.rentDeposits)),
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


