
import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Helper/TextHelper.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/DetailsList.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class AdditionalTermCard extends StatelessWidget  {
  final AdditionalTerm additionalTerm;
  final Function(BuildContext context, AdditionalTerm additonalTerm) onItemRemoved;
  const AdditionalTermCard({Key? key, required this.additionalTerm, required this.onItemRemoved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return  Card(
      child: Column(children: [
        ListTile(
          leading: const Icon(Icons.assignment),
          title: TextHelper(text: additionalTerm.name),
          trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            onItemRemoved(context, additionalTerm);
          },
        ),
        ),
        DetailsList(details: additionalTerm.details.map<String>((Detail detail) => detail.detail).toList())
      ]),
    );
  }




}

