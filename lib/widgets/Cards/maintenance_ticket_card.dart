
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord.dart';

import '../../business_logic/maintenance_ticket_notification.dart';
import '../../pages/maintenance_ticket_pages/comments_page.dart';
import '../Buttons/SecondaryButton.dart';

class MaintenanceTicketNotificationCard extends StatelessWidget {
  final Landlord landlord;
  final MaintenanceTicketNotification maintenanceTicketNotification;

  const MaintenanceTicketNotificationCard(
      {Key? key, required this.maintenanceTicketNotification, required this.landlord})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                Icons.account_circle,
                size: 40,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 16),
                alignment: Alignment.bottomLeft,
                child: Text(
                  maintenanceTicketNotification.getFullName(),
                  textAlign: TextAlign.left,
                ))
          ],
        ),
        Row(children: [
          Container(
              margin: const EdgeInsets.only(left: 16),
              child: const Text("This is a description"))
        ]),
        Container(
          margin: const EdgeInsets.all(8),
          height: 200,
          constraints: const BoxConstraints(maxWidth: 600),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width,
          child: Image.network(maintenanceTicketNotification.data.imageURL, fit: BoxFit.fill,),
        ),
        
          SecondaryButton(Icons.chevron_right_rounded, "Open Maintenance Ticket",
              (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CommentsPage(
                        maintenanceTicketId: maintenanceTicketNotification.data.maintenanceTicketId, houseKey: maintenanceTicketNotification.houseKey, landlord: landlord,
                      )),
            );
          }),
        
      ]),
    );
  }
}
