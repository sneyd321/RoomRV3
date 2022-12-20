import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/widgets/Cards/custom_notification_card.dart';

import '../../business_logic/house.dart';
import '../../business_logic/maintenance_ticket_notification.dart';
import '../Cards/ApproveTenantNotification.dart';
import '../Cards/InviteTenantNotificationCard.dart';
import '../Cards/TenantAccountCreatedNotification.dart';
import '../Cards/download_lease_notification.dart';
import '../Cards/maintenance_ticket_card.dart';
import '../Listviews/CardSliverListView.dart';

class NotificationSearch extends StatefulWidget {
  final Landlord landlord;
  final House house;
  final List<QueryDocumentSnapshot> documents;
  const NotificationSearch(
      {Key? key, required this.landlord, required this.documents, required this.house})
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
        Container(
          margin: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: searchTextEditingController,
            onChanged: (value) {
              setState(() {
                queryDocumentSnapshots = widget.documents.where((element) {
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
        Expanded(
          child: CardSliverListView(
            items: queryDocumentSnapshots,
            builder: (context, index) {
              QueryDocumentSnapshot document = widget.documents[index];
              switch (document.get("Name")) {
                case "MaintenanceTicket":
                  return MaintenanceTicketNotificationCard(
                    house: widget.house,
                    landlord: widget.landlord,
                    document: document,);
 
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
                case "Custom":
                  return CustomNotificationCard(document: document);
                default:
                  return Text(
                      "TODO: Make notification for event: ${document.get("Name")}");
              }
            },
            controller: ScrollController(),
          ),
        ),
      ],
    );
  }
}
