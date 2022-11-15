import 'dart:async';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/widgets/Cards/ApproveTenantNotification.dart';
import 'package:notification_app/widgets/Cards/InviteTenantNotificationCard.dart';
import 'package:rxdart/rxdart.dart';

import '../../../business_logic/house.dart';
import '../../business_logic/maintenance_ticket_notification.dart';
import '../Cards/download_lease_notification.dart';
import '../Cards/maintenance_ticket_card.dart';
import '../Listviews/CardSliverListView.dart';

class NotificationStreamBuilder extends StatefulWidget {
  final List<House> houses;
  final Landlord landlord;
  const NotificationStreamBuilder(
      {Key? key, required this.houses, required this.landlord})
      : super(key: key);

  @override
  State<NotificationStreamBuilder> createState() =>
      _NotificationStreamBuilderState();
}

class _NotificationStreamBuilderState extends State<NotificationStreamBuilder> {
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
                    .snapshots())
            .toList());
    return combinedStreams.cast();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: StreamBuilder<List<QuerySnapshot<Map<String, dynamic>>>>(
        stream: getCombinedStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const Text("Loading");
          }
          List<QueryDocumentSnapshot> queryDocumentSnapshots = [];

          for (QuerySnapshot<Map<String, dynamic>> snapshot in snapshot.data!) {
            queryDocumentSnapshots.addAll(snapshot.docs);
          }

          return CardSliverListView(
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
                    documentURL: document.get("data")["documentURL"],
                    houseKey: document.get("houseKey"),
                  );
                case "InvitePendingTenant":
                  return InviteTenantNotificationCard(document: document);
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
