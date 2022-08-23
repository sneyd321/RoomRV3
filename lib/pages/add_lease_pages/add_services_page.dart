import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordAddressForm.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/ServicesList.dart';

class AddServicesPage extends StatefulWidget {
  final Lease lease;

  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddServicesPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddServicesPage> createState() => _AddServicesPageState();
}

class _AddServicesPageState extends State<AddServicesPage> {
  String errorText = "";
  void onNextCallback(BuildContext context) {
    errorText = "";
    List<String> serviceNames = widget.lease.services.map<String>((Service service) => service.name).toList();
    List<String> differences = {"Gas", "Air Conditioning", "Additional Storage Space", "On-Site Laundry", "Guest Parking"}.difference(serviceNames.toSet()).toList();
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
        case "Gas":
          widget.lease.services.insert(0, GasService());
          continue;
        case "Air Conditioning":
          widget.lease.services.insert(1, AirConditioningService());
          continue;
        case "Additional Storage Space":
          widget.lease.services.insert(2, AdditionalStorageSpace());
          continue;
        case "On-Site Laundry":
          widget.lease.services.insert(3, OnSiteLaundry());
          continue;
        case "Guest Parking":
          widget.lease.services.insert(4 ,GuestParking());
          continue;
      }
    }
    setState(() {
      errorText += " service(s) required";
    });
    
    
  }

  void onBackCallback(BuildContext context) {
    widget.onBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: ServicesList(services: widget.lease.services)),
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


