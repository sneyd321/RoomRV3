import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/list_items/rent_services.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddAmountForm.dart';
import 'package:notification_app/widgets/Helper/BottomSheetHelper.dart';
import 'package:notification_app/widgets/Navigation/bottom_nav_bar.dart';

class RentServiceCard extends StatefulWidget {
  final RentService rentService;
  final Function(BuildContext context, RentService rentService) onItemRemoved;

  const RentServiceCard(
      {Key? key, required this.rentService, required this.onItemRemoved})
      : super(key: key);

  @override
  State<RentServiceCard> createState() => _RentServiceCardState();
}

class _RentServiceCardState extends State<RentServiceCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: ListTile(
        leading: const Icon(Icons.home_repair_service),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.rentService.name),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  BottomSheetHelper(AddAmountForm(
                    onSave: (context, amount) {
                      setState(() {
                       widget.rentService.amount = amount; 
                      });
                      Navigator.pop(context);
                    },
                  )).show(context);
                },
                child: Text("\$${widget.rentService.amount}")),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            widget.onItemRemoved(context, widget.rentService);
          },
        ),
      ),
    );
  }
}
