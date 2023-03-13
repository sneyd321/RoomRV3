import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/builders/notification_search.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class NotificationLimit extends StatefulWidget {
  final House house;
  final Landlord landlord;
  final void Function() onSearchFocus;
  const NotificationLimit(
      {Key? key, required this.house, required this.landlord, required this.onSearchFocus})
      : super(key: key);

  @override
  State<NotificationLimit> createState() => _NotificationLimitState();
}

class _NotificationLimitState extends State<NotificationLimit> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<QueryDocumentSnapshot> queryDocumentSnapshots =
            snapshot.data!.docs;

        return NotificationSearch(
          landlord: widget.landlord,
          documents: queryDocumentSnapshots,
          house: widget.house,
          onSearchFocus: widget.onSearchFocus,
        );
      },
    );
  }
}
