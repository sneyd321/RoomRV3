import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/widgets/builders/notification_search.dart';

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
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('House')
              .doc(widget.house.firebaseId)
              .collection("Landlord")
              .orderBy("dateCreated", descending: true)
              .limit(3)
              .get(),
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
            List<QueryDocumentSnapshot> queryDocumentSnapshots = snapshot.data!.docs;
            
            return NotificationSearch(landlord: widget.landlord, documents: queryDocumentSnapshots);
          },
        )
      ],
    );
  }
}
