import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/DepositsList.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../../graphql/mutation_helper.dart';
import '../../widgets/buttons/SecondaryActionButton.dart';

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
               Container(
                 margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                 child: SecondaryActionButton(text: "Update Rent Deposits", onClick: () {
                  
                  if (validate()) {
                    runMutation({
                      "houseId": widget.house.houseId,
                      "rentDeposits": widget.house.lease.rentDeposits
                          .map((rentDeposit) => rentDeposit.toJson())
                          .toList()
                    });
                  }
              }),
               )
          ],
        );
      }
    );
  }
}


