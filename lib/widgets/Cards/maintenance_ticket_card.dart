
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
          ListTile(
           visualDensity: VisualDensity(vertical: 0.5),
                isThreeLine: true,
            leading: const CircleAvatar(child: Icon(Icons.build)),
            title: const Text("New Maintenance Ticket Reported"),
            subtitle: Text("Reported by: ${maintenanceTicketNotification.getFullName()}"),
            trailing: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(25)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: Colors.black)))),
                  onPressed: () async {
                    
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                          
                            content: Container(
                              constraints: const BoxConstraints(maxWidth: 400),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("data")
                                 
                                 
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: const Text(
                    "View Details",
                    style: TextStyle(fontSize: 16),
                  )),
            ),
          )
        
         
        
      ]),
    );
  }
}
