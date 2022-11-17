import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/list_items/utility.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/UtilitiesList.dart';

class UpdateUtilityPage extends StatefulWidget {
  final House house;

  const UpdateUtilityPage(
      {Key? key,
      required this.house})
      : super(key: key);

  @override
  State<UpdateUtilityPage> createState() => _UpdateUtilityPageState();
}

class _UpdateUtilityPageState extends State<UpdateUtilityPage> {
  String errorText = "";


  bool validate() {
    errorText = "";
    List<String> utilityNames = widget.house.lease.utilities.map<String>((Utility utility) => utility.name).toList();
    List<String> differences = {"Electricity", "Heat", "Water"}.difference(utilityNames.toSet()).toList();
    if (differences.isEmpty) {
      setState(() {
       
      });
      return true;
    }
    for (String element in differences) {
      errorText += errorText.isEmpty ? element : ", $element"; 
      switch (element) {
        case "Electricity":
          widget.house.lease.utilities.insert(0, ElectricityUtility());
          continue;
        case "Heat":
          widget.house.lease.utilities.insert(1, HeatUtility());
          continue;
        case "Water":
          widget.house.lease.utilities.insert(2, WaterUtility());
          continue;
 
       
      }
    }
    setState(() {
      errorText += " utilities(s) required";
    });
    return false;
    
    
  }


  @override
  Widget build(BuildContext context) {
    return MutationHelper(
      mutationName: "updateUtilities",
      onComplete: (json) {
        
      },
      builder: (runMutation) {
        return Column(
          children: [
            Expanded(child: UtilitiesList(utilities: widget.house.lease.utilities,)),
            Container(
              margin: const EdgeInsets.only(left: 8, bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 18),)),
            SecondaryButton(Icons.update, "Update Utilities", (context) {
              if (validate()) {
                  runMutation({
                    "houseId": widget.house.houseId,
                    "utilities": widget.house.lease.utilities
                        .map((utility) => utility.toJson())
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


