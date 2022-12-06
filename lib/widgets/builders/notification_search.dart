import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord.dart';

import '../../business_logic/maintenance_ticket_notification.dart';
import '../Cards/ApproveTenantNotification.dart';
import '../Cards/InviteTenantNotificationCard.dart';
import '../Cards/TenantAccountCreatedNotification.dart';
import '../Cards/download_lease_notification.dart';
import '../Cards/maintenance_ticket_card.dart';
import '../Listviews/CardSliverListView.dart';

class NotificationSearch extends StatefulWidget {
  final Landlord landlord;
  final List<QueryDocumentSnapshot> documents;
  const NotificationSearch(
      {Key? key, required this.landlord, required this.documents})
      : super(key: key);

  @override
  State<NotificationSearch> createState() => _NotificationSearchState();
}

class _NotificationSearchState extends State<NotificationSearch> {
  final TextEditingController searchTextEditingController =
      TextEditingController();
  List<QueryDocumentSnapshot> queryDocumentSnapshots = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    queryDocumentSnapshots = widget.documents;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Text(
                "Notifications",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )),
            Flexible(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(8),
                child: TextField(
                  controller: searchTextEditingController,
                  onChanged: (value) {
                    setState(() {
                      queryDocumentSnapshots =
                          widget.documents.where((element) {

                        return element
                            .data()
                            .toString()
                            .toLowerCase()
                            .contains(value.toLowerCase());
                      }).toList();
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: (() {
                          setState(() {
                            searchTextEditingController.text = "";
                            queryDocumentSnapshots = widget.documents;
                          });
                        }),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Search Keywords",
                      fillColor: Colors.white70),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 300,
          child: CardSliverListView(
            items: queryDocumentSnapshots,
            builder: (context, index) {
              QueryDocumentSnapshot document = widget.documents[index];
              switch (document.get("Name")) {
                case "MaintenanceTicket":
                  return MaintenanceTicketNotificationCard(
                    landlord: widget.landlord,
                    maintenanceTicketNotification:
                        MaintenanceTicketNotification.fromJson(
                            document.data() as Map<String, dynamic>),
                  );
                case "DownloadLease":
                  return DownloadLeaseNotificationCard(
                    document: document,
                  );
                case "InvitePendingTenant":
                  return InviteTenantNotificationCard(document: document);
                case "TenantAccountCreated":
                  return TenantAccountCreatedNotification(document: document);
                case "ApproveTenant":
                  return ApproveTenantNotificationCard(document: document);
                default:
                  return Text(
                      "TODO: Make notification for event: ${document.get("Name")}");
              }
            },
            controller: ScrollController(),
          ),
        )
      ],
    );
  }
}
