import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/DetailsList.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../Helper/TextHelper.dart';

class UtiltiyCard extends StatefulWidget {
  final Utility utility;
  final Function(BuildContext context, Utility utility) onItemRemoved;

  const UtiltiyCard(
      {Key? key, required this.utility, required this.onItemRemoved})
      : super(key: key);

  @override
  State<UtiltiyCard> createState() => _UtiltiyCardState();
}

class _UtiltiyCardState extends State<UtiltiyCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: TextHelper(text: widget.utility.name),
            trailing: IconButton(icon: const Icon(Icons.close), onPressed: () {
              widget.onItemRemoved(context, widget.utility);
            },),
          ),
          CheckboxListTile(
            
            title: TextHelper(
                text:
                    "Is the responsibility of the ${widget.utility.responsibility}"),
            onChanged: (bool? value) {
              setState(() {
                widget.utility
                    .setResponsibility(value! ? "Landlord" : "Tenant");
              });
            },
            value: widget.utility.responsibility == "Landlord",
          ),
          Visibility(
            visible: widget.utility.responsibility == "Tenant",
            child: DetailsList(details: widget.utility.details.map<String>((Detail detail) => detail.detail).toList()),
          )
        ],
      ),
    );
  }
}
