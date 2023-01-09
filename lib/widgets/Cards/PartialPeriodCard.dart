import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class PartialPeriodCard extends StatefulWidget {
  final PartialPeriod partialPeriod;

  const PartialPeriodCard({Key? key, required this.partialPeriod}) : super(key: key);

  @override
  State<PartialPeriodCard> createState() => _PartialPeriodCardState();
}

class _PartialPeriodCardState extends State<PartialPeriodCard> {
  


  @override
  Widget build(BuildContext context) {
     return Visibility(
                visible: widget.partialPeriod.isEnabled,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.money),
                      title: Text("\$${widget.partialPeriod.amount} due on ${widget.partialPeriod.dueDate}"),
                      subtitle: Text("From ${widget.partialPeriod.startDate} to ${widget.partialPeriod.endDate}"),
                      trailing: IconButton(onPressed: () {
                        setState(() {
                          bool currentValue = widget.partialPeriod.isEnabled;
                          widget.partialPeriod.setEnabled(!currentValue);
                        });
                      }, icon: const Icon(Icons.close)),
                    ),
                  ),
                ),
              );
  }
}