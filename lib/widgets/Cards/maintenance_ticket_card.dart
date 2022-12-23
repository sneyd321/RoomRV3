import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';

import '../Navigation/navigation.dart';
import '../buttons/IconTextColumn.dart';

class MaintenanceTicketNotificationCard extends StatefulWidget {
  final Landlord landlord;
  final House house;
  final QueryDocumentSnapshot document;

  const MaintenanceTicketNotificationCard(
      {Key? key, required this.document, required this.landlord, required this.house})
      : super(key: key);

  @override
  State<MaintenanceTicketNotificationCard> createState() =>
      _MaintenanceTicketNotificationCardState();
}

class _MaintenanceTicketNotificationCardState
    extends State<MaintenanceTicketNotificationCard> {
  String parseTimestamp(Timestamp timestamp) {
    return DateFormat('dd/MM/yyyy HH:mm').format(timestamp.toDate());
  }

  void showMaintenanceTicketDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Maintenance Ticket #${widget.document.get("data")["maintenanceTicketId"]}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text("Date Issued: ${parseTimestamp(widget.document.get("dateCreated"))}",
                    style:
                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: Image.network(
                          widget.document.get("data")['imageURL'],
                        ).image,
                      )),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(widget.document.get("data")["description"])),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconTextColumn(
                        profileColor: Colors.blueGrey,
                        iconColor: Colors.white,
                        textColor: Colors.black,
                        icon: Icons.comment,
                        text: "Comment",
                        onClick: () {
                          Navigation().navigateToCommentsPage(
                              context, widget.landlord, widget.house.houseKey, widget.document.get("data")["maintenanceTicketId"]);
                        }),
                    IconTextColumn(
                        profileColor: Colors.blueGrey,
                        iconColor: Colors.white,
                        textColor: Colors.black,
                        icon: Icons.date_range,
                        text: "Schedule",
                        onClick: () {
                          const snackBar = SnackBar(
                            content: Text('Feature Coming Soon'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }),
                    IconTextColumn(
                        profileColor: Colors.blueGrey,
                        iconColor: Colors.white,
                        textColor: Colors.black,
                        icon: Icons.call,
                        text: "Call Tenant",
                        onClick: () {
                          const snackBar = SnackBar(
                            content: Text('Feature Coming Soon'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMaintenanceTicketDialog();
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
              visualDensity: VisualDensity(vertical: 0.5),
              leading: const CircleAvatar(
                child: Icon(
                  Icons.build,
                  color: Colors.white,
                ),
                backgroundColor: Colors.red,
              ),
              title: const Text("Maintenance Ticket Reported"),
              subtitle: Text(
                  "Reported on: ${parseTimestamp(widget.document.get("dateCreated"))}"),
              trailing: IconButton(
                onPressed: () {
                  showMaintenanceTicketDialog();
                },
                icon: const Icon(Icons.chevron_right_rounded))),
        ]),
      ),
    );
  }
}
