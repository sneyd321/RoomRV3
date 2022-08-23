import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/list_items/rent_services.dart';


class RentServiceCard extends StatelessWidget {

  final RentService rentService;
  final Function(BuildContext context, RentService rentService) onItemRemoved;

  const RentServiceCard({Key? key, required this.rentService, required this.onItemRemoved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: const Icon(Icons.home_repair_service),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(rentService.name),
            const Spacer(),
            Text("\$${rentService.amount}"),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            onItemRemoved(context, rentService);
          },
        ),
      ),
    );
  }
}
