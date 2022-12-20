import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/widgets/builders/notification_search.dart';

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
            landlord: widget.landlord, documents: queryDocumentSnapshots, house: widget.house,);
      },
    );
  }
}
