import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class PayPerUseServiceCard extends StatefulWidget {
  
  final Service service;
  final void Function(BuildContext context, Service payPerUseService) onItemRemoved;

  const PayPerUseServiceCard({Key? key, required this.service, required this.onItemRemoved}) : super(key: key);

  @override
  State<PayPerUseServiceCard> createState() => _PayPerUseServiceCardState();
}

class _PayPerUseServiceCardState extends State<PayPerUseServiceCard> {
  void onAddDetail(BuildContext context) {
    
  }

  void onSaveService(buildContext, service) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8),
        child: Column(children: [
          ListTile(
            title: Text(widget.service.name),
            trailing: IconButton(icon: const Icon(Icons.close), onPressed: () {
              widget.onItemRemoved(context, widget.service);
            },),
          ),
          CheckboxListTile(
              title: Text( widget.service.includedInRent ? "Included in the lawful rent for the rental unit": "Not Included in the lawful rent for the rental unit"),
              value: widget.service.includedInRent,
              onChanged: (bool? value) {
                setState(() {
                  widget.service.updateIncludedInRent(value!);
                });
              }),
          CheckboxListTile(
              subtitle: Text( widget.service.payPerUse ? "Pay per use" : "No Charge"),
              value: widget.service.payPerUse,
              onChanged: (bool? value) {
                setState(() {
                  widget.service.updateIsPayPerUse(value!);
                });
              }),
         
        ]));
  }
}
