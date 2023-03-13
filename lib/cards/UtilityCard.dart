import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


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
            title: Text(widget.utility.name),
            trailing: IconButton(icon: const Icon(Icons.close), onPressed: () {
              widget.onItemRemoved(context, widget.utility);
            },),
          ),
          CheckboxListTile(
            
            title: Text(
            
                    "Is the responsibility of the ${widget.utility.responsibility}"),
            onChanged: (bool? value) {
              setState(() {
                widget.utility
                    .updateResponsibility(value! ? UtilityResponsibility.landlord : UtilityResponsibility.tenant);
              });
            },
            value: widget.utility.responsibility == "Landlord",
          ),
          
        ],
      ),
    );
  }
}
