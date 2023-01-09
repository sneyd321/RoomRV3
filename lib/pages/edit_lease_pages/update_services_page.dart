import 'package:flutter/material.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/ServicesList.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../../widgets/buttons/SecondaryActionButton.dart';

class UpdateServicesPage extends StatefulWidget {
  final House house;

  const UpdateServicesPage(
      {Key? key,
    
      required this.house})
      : super(key: key);

  @override
  State<UpdateServicesPage> createState() => _UpdateServicesPageState();
}

class _UpdateServicesPageState extends State<UpdateServicesPage> {
    String errorText = "";
   bool validate() {
    errorText = "";
    List<String> serviceNames = widget.house.lease.services
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
          widget.house.lease.services.insert(0, GasService());
          continue;
        case "Air Conditioning":
          widget.house.lease.services.insert(0, AirConditioningService());
          continue;
        case "Additional Storage Space":
          widget.house.lease.services.insert(0, AdditionalStorageSpace());
          continue;
        case "On-Site Laundry":
          widget.house.lease.services.insert(0, OnSiteLaundry());
          continue;
        case "Guest Parking":
          widget.house.lease.services.insert(0, GuestParking());
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
    return MutationHelper(
      mutationName: "updateServices",
      onComplete: ((json) {
        
      }),
      builder: (runMutation) {
        return Column(
          children: [
            Expanded(child: ServicesList(services: widget.house.lease.services)),
            Container(
              margin: const EdgeInsets.only(left: 8, bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 18),)),
               Container(
                 margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                 child: SecondaryActionButton(text: "Update Services", onClick: () {
                  if (validate()) {
                    runMutation({
                      "houseId": widget.house.houseId,
                      "services": widget.house.lease.services
                          .map((service) => service.toJson())
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


