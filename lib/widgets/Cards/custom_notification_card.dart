import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNotificationCard extends StatelessWidget {
  final QueryDocumentSnapshot document;
  const CustomNotificationCard({Key? key, required this.document})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: ListTile(
          visualDensity: const VisualDensity(vertical: 0.5),
          leading: const CircleAvatar(
              child: Icon(
                Icons.notifications_active,
                color: Colors.white,
              ),
              backgroundColor: Colors.green),
          title: Text(document.get("title")),
          subtitle: Text(document.get("body")),
        ),
      ),
    );
  }
}
