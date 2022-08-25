import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/business_logic/list_items/utility.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordAddressForm.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/ServicesList.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/UtilitiesList.dart';

class AddUtilityPage extends StatefulWidget {
  final Lease lease;

  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddUtilityPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddUtilityPage> createState() => _AddUtilityPageState();
}

class _AddUtilityPageState extends State<AddUtilityPage> {
  String errorText = "";


  void onNextCallback(BuildContext context) {
    errorText = "";
    List<String> utilityNames = widget.lease.utilities.map<String>((Utility utility) => utility.name).toList();
    List<String> differences = {"Electricity", "Heat", "Water"}.difference(utilityNames.toSet()).toList();
    if (differences.isEmpty) {
      setState(() {
       
      });
      widget.onNext(context);
      return;
    }
    for (String element in differences) {
      errorText += errorText.isEmpty ? element : ", $element"; 
      switch (element) {
        case "Electricity":
          widget.lease.utilities.insert(0, ElectricityUtility());
          continue;
        case "Heat":
          widget.lease.utilities.insert(1, HeatUtility());
          continue;
        case "Water":
          widget.lease.utilities.insert(2, WaterUtility());
          continue;
 
       
      }
    }
    setState(() {
      errorText += " utilities(s) required";
    });
    
    
  }

  void onBackCallback(BuildContext context) {
    widget.onBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: UtilitiesList(utilities: widget.lease.utilities,)),
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


