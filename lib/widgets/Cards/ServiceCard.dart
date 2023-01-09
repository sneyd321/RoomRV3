import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Helper/TextHelper.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/DetailsList.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class ServiceCard extends StatefulWidget {
  final Service service;
  final void Function(BuildContext context, Service item) onItemRemoved;
  const ServiceCard(
      {Key? key, required this.service, required this.onItemRemoved})
      : super(key: key);

  @override
  State<ServiceCard> createState() {
    return _ServiceCardState();
  }
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: TextHelper(text: widget.service.name),
              trailing: IconButton(icon: const Icon(Icons.close), onPressed: () {
                widget.onItemRemoved(context, widget.service);
              },),
            ),
            CheckboxListTile(
                title: TextHelper(
                    text: widget.service.isIncludedInRent
                        ? "Included in the lawful rent for the rental unit"
                        : "Not Included in the lawful rent for the rental unit"),
                value: widget.service.isIncludedInRent,
                onChanged: (bool? value) {
                  setState(() {
                    widget.service.setIncludedInRent(value!);
                  });
                }),
            DetailsList(details: widget.service.details.map<String>((Detail detail) => detail.detail).toList()),
          ],
        ));
  }
}
