import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/ServicesList.dart';
import 'package:notification_app/widgets/mutations/services_mutation.dart';

class UpdateServicesPage extends StatefulWidget {
  final Lease lease;

  final Function(BuildContext context) onUpdate;
  const UpdateServicesPage(
      {Key? key,
      required this.onUpdate,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateServicesPage> createState() => _UpdateServicesPageState();
}

class _UpdateServicesPageState extends State<UpdateServicesPage> {
    String errorText = "";
   bool validate() {
    errorText = "";
    List<String> serviceNames = widget.lease.services
        .map<String>((Service service) => service.name)
        .toList();
    List<String> differences = {
      "Gas",
      "Air Conditioning",
      "Additional Storage Space",
      "On-Site Laundry",
      "Guest Parking"
    }.difference(serviceNames.toSet()).toList();
    if (differences.isEmpty) {
      setState(() {
        errorText = "";
      });
      return true;
    }
    for (String element in differences) {
      errorText += errorText.isEmpty ? element : ", $element";
      switch (element) {
        case "Gas":
          widget.lease.services.insert(0, GasService());
          continue;
        case "Air Conditioning":
          widget.lease.services.insert(0, AirConditioningService());
          continue;
        case "Additional Storage Space":
          widget.lease.services.insert(0, AdditionalStorageSpace());
          continue;
        case "On-Site Laundry":
          widget.lease.services.insert(0, OnSiteLaundry());
          continue;
        case "Guest Parking":
          widget.lease.services.insert(0, GuestParking());
          continue;
      }
    }
    setState(() {
      errorText += " service(s) required";
    });
    return false;
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
         UpdateServicesMutation(onComplete: (context, services) {
           
         }, lease: widget.lease, validate: validate,)
      ],
    );
  }
}


