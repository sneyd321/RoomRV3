import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/deposit.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/DepositsList.dart';

import '../../business_logic/house.dart';
import '../../graphql/mutation_helper.dart';

class UpdateRentDepositPage extends StatefulWidget {
  final House house;

  const UpdateRentDepositPage(
      {Key? key,
      required this.house})
      : super(key: key);

  @override
  State<UpdateRentDepositPage> createState() => _UpdateRentDepositPageState();
}

class _UpdateRentDepositPageState extends State<UpdateRentDepositPage> {
  String errorText = "";
  bool validate() {
    errorText = "";
    List<String> serviceNames = widget.house.lease.rentDeposits.map<String>((Deposit rentDeposit) => rentDeposit.name).toList();
    List<String> differences = {"Rent Deposit", "Key Deposit", "Pet Damage Deposit", "Maintenance Ticket Deductable"}.difference(serviceNames.toSet()).toList();
    if (differences.isEmpty) {
      setState(() {
        errorText = "";
      });
      
      return true;
    }
    for (String element in differences) {
      errorText += errorText.isEmpty ? element : ", $element"; 
      switch (element) {
        case "Rent Deposit":
          widget.house.lease.rentDeposits.insert(0, RentDeposit(widget.house.lease.rent.baseRent));
          continue;
        case "Key Deposit":
          widget.house.lease.rentDeposits.insert(1, KeyDeposit());
          continue;
        case "Pet Damage Deposit":
          widget.house.lease.rentDeposits.insert(2, PetDamageDeposit());
          continue;
        case "Maintenance Ticket Deductable":
          widget.house.lease.rentDeposits.insert(3, MaintenanceDeductableDeposit());
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
    return MutationHelper(
      mutationName: "updateRentDeposits",
      onComplete: ((json) {
        
      }),
      builder: (runMutation) {
        return Column(
          children: [
            Expanded(child: DepositsList(deposits: widget.house.lease.rentDeposits)),
            Container(
              margin: const EdgeInsets.only(left: 8, bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 18),)),
              SecondaryButton(Icons.update, "Update Rent Deposit", (context) {
                
                if (validate()) {
                  runMutation({
                    "houseId": widget.house.lease.leaseId,
                    "rentDeposits": widget.house.lease.rentDeposits
                        .map((rentDeposit) => rentDeposit.toJson())
                        .toList()
                  });
                }
              })
          ],
        );
      }
    );
  }
}


