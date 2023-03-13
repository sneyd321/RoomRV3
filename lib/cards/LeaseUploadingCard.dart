import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaseUploadingCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final IconData icon;
  const LeaseUploadingCard(
      {Key? key, required this.notification, required this.icon})
      : super(key: key);


  String parseTimestamp(Timestamp timestamp) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    return dateFormat.format(timestamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
       leading: Container(
              height: 46,
              width: 46,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
              alignment: Alignment.center,
            ),
            title: Text(notification["body"]),
            subtitle: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Text(
                  "Created on: ${parseTimestamp(notification["dateCreated"])}"),
            ),
            isThreeLine: true,
          ),

    );
  }
}
