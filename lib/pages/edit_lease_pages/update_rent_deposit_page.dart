import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/deposit.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/DepositsList.dart';
import 'package:notification_app/widgets/mutations/rent_deposits_mutation.dart';
import 'package:notification_app/widgets/mutations/rent_discount_mutation.dart';

class UpdateRentDepositPage extends StatefulWidget {
  final Lease lease;

  final Function(BuildContext context) onUpdate;
  const UpdateRentDepositPage(
      {Key? key,
      required this.onUpdate,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateRentDepositPage> createState() => _UpdateRentDepositPageState();
}

class _UpdateRentDepositPageState extends State<UpdateRentDepositPage> {
  String errorText = "";
  bool validate() {
    errorText = "";
    List<String> serviceNames = widget.lease.rentDeposits.map<String>((Deposit rentDeposit) => rentDeposit.name).toList();
    List<String> differences = {"Rent Deposit", "Key Deposit", "Pet Damage Deposit", "Maintenance Ticket Deductable"}.difference(serviceNames.toSet()).toList();
    print(differences);
    if (differences.isEmpty) {
      setState(() {
        errorText = "";
      });
      widget.onUpdate(context);
      return true;
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
    return false;
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
         UpdateDepositMutation(lease: widget.lease, onComplete: ((context, discounts) {
           
         }), validate: validate)
      ],
    );
  }
}


