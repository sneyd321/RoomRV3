import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';

import '../../business_logic/maintenance_ticket_notification.dart';
import '../Cards/ApproveTenantNotification.dart';
import '../Cards/InviteTenantNotificationCard.dart';
import '../Cards/TenantAccountCreatedNotification.dart';
import '../Cards/download_lease_notification.dart';
import '../Cards/maintenance_ticket_card.dart';
import '../Listviews/CardSliverListView.dart';

class NotificationLimit extends StatefulWidget {
  final House house;
  final Landlord landlord;
  const NotificationLimit(
      {Key? key, required this.house, required this.landlord})
      : super(key: key);

  @override
  State<NotificationLimit> createState() => _NotificationLimitState();
}

class _NotificationLimitState extends State<NotificationLimit> {
  final TextEditingController searchTextEditingController =
      TextEditingController();
  String searchText = "";
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
                      searchText = value;
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
                            searchText = "";
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
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('House')
              .doc(widget.house.firebaseId)
              .collection("Landlord")
              .orderBy("dateCreated", descending: true)
              .limit(3)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<QueryDocumentSnapshot> queryDocumentSnapshots =
                snapshot.data!.docs;
            if (searchText.isNotEmpty) {
              queryDocumentSnapshots = queryDocumentSnapshots.where((element) {
                return element
                    .data()
                    .toString()
                    .toLowerCase()
                    .contains(searchText.toLowerCase());
              }).toList();
            }

            return CardSliverListView(
              shrinkWrap: true,
              items: queryDocumentSnapshots,
              builder: (context, index) {
                QueryDocumentSnapshot document = queryDocumentSnapshots[index];
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
            );
          },
        )
      ],
    );
  }
}
