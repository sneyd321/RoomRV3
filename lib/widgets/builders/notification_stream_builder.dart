import 'dart:async';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/widgets/Cards/ApproveTenantNotification.dart';
import 'package:notification_app/widgets/Cards/InviteTenantNotificationCard.dart';
import 'package:notification_app/widgets/Cards/TenantAccountCreatedNotification.dart';

import '../../../business_logic/house.dart';
import '../../business_logic/maintenance_ticket_notification.dart';
import '../Cards/download_lease_notification.dart';
import '../Cards/maintenance_ticket_card.dart';
import '../Listviews/CardSliverListView.dart';

class NotificationStreamBuilder extends StatefulWidget {
  final House house;
  final Landlord landlord;
  final TextEditingController textEditingController;

  const NotificationStreamBuilder(
      {Key? key, required this.house, required this.landlord, required this.textEditingController})
      : super(key: key);

  @override
  State<NotificationStreamBuilder> createState() =>
      _NotificationStreamBuilderState();
}

class _NotificationStreamBuilderState extends State<NotificationStreamBuilder> {
  /*
  Stream<List<QuerySnapshot<Map<String, dynamic>>>> getCombinedStream() {
    CombineLatestStream<QuerySnapshot<Map<String, dynamic>>,
            List<QuerySnapshot<Map<String, dynamic>>>> combinedStreams =
        CombineLatestStream.list(widget.houses
            .map<Stream<QuerySnapshot<Map<String, dynamic>>>>((House house) =>
                FirebaseFirestore.instance
                    .collection('House')
                    .doc(house.firebaseId)
                    .collection("Landlord")
                    .orderBy("dateCreated", descending: true)
                    .limit(3)
                    .snapshots())
            .toList());
    return combinedStreams.cast();
  }
  */

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('House')
            .doc(widget.house.firebaseId)
            .collection("Landlord")
            .orderBy("dateCreated", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text("No Notifications"),
              ),
            );
          }
          List<QueryDocumentSnapshot> queryDocumentSnapshots =
              snapshot.data!.docs.where((element) {
                print(widget.textEditingController.text);
            return element
                .data()
                .toString()
                .toLowerCase()
                .contains(widget.textEditingController.text.toLowerCase());
          }).toList();

          return CardSliverListView(
            shrinkWrap: true,
            items: queryDocumentSnapshots,
            builder: (context, index) {
              QueryDocumentSnapshot document = queryDocumentSnapshots[index];
              switch (document.get("Name")) {
                case "MaintenanceTicket":
                  return MaintenanceTicketNotificationCard(
                    landlord: widget.landlord,
                    document: document);
                  
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
      ),
    );
  }
}
