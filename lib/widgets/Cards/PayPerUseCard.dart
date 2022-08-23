import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/list_items/detail.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:notification_app/widgets/Helper/BottomSheetHelper.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/DetailsList.dart';
import '../../business_logic/list_items/service.dart';
import '../Helper/TextHelper.dart';

class PayPerUseServiceCard extends StatefulWidget {
  
  final PayPerUseService payPerUseService;
  final void Function(BuildContext context, PayPerUseService payPerUseService) onItemRemoved;

  const PayPerUseServiceCard({Key? key, required this.payPerUseService, required this.onItemRemoved}) : super(key: key);

  @override
  State<PayPerUseServiceCard> createState() => _PayPerUseServiceCardState();
}

class _PayPerUseServiceCardState extends State<PayPerUseServiceCard> {
  void onAddDetail(BuildContext context) {
    BottomSheetHelper(AddNameForm(
      onSave: onSaveService,
      names: const [],
    )).show(context);
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
            title: TextHelper(text: widget.payPerUseService.name),
            trailing: IconButton(icon: const Icon(Icons.close), onPressed: () {
              widget.onItemRemoved(context, widget.payPerUseService);
            },),
          ),
          CheckboxListTile(
              title: TextHelper(text: widget.payPerUseService.isIncludedInRent ? "Included in the lawful rent for the rental unit": "Not Included in the lawful rent for the rental unit"),
              value: widget.payPerUseService.isIncludedInRent,
              onChanged: (bool? value) {
                setState(() {
                  widget.payPerUseService.setIncludedInRent(value!);
                });
              }),
          CheckboxListTile(
              subtitle: TextHelper(text: widget.payPerUseService.isPayPerUse ? "Pay per use" : "No Charge"),
              value: widget.payPerUseService.isPayPerUse,
              onChanged: (bool? value) {
                setState(() {
                  widget.payPerUseService.setPayPerUse(value!);
                });
              }),
            DetailsList(details: widget.payPerUseService.details.map<String>((Detail detail) => detail.detail).toList()),
         
        ]));
  }
}
