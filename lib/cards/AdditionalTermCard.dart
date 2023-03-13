
import 'package:flutter/material.dart';
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
          title: Text(additionalTerm.name),
          trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            onItemRemoved(context, additionalTerm);
          },
        ),
        ),
      ]),
    );
  }




}

