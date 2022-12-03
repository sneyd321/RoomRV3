import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

import '../../services/network.dart';
import '../../services/web_network.dart';

class TenantAccountCreatedNotification extends StatefulWidget {
  final QueryDocumentSnapshot document;
  const TenantAccountCreatedNotification({Key? key, required this.document})
      : super(key: key);

  @override
  State<TenantAccountCreatedNotification> createState() =>
      _TenantAccountCreatedNotificationState();
}

class _TenantAccountCreatedNotificationState
    extends State<TenantAccountCreatedNotification> {
  late Map<String, dynamic> data;
  late String path;
  @override
  void initState() {
    super.initState();
    data = widget.document.data() as Map<String, dynamic>;
    path = widget.document.reference.path;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: ListTile(
        visualDensity: VisualDensity(vertical: 0.5),
        isThreeLine: true,
        leading: const CircleAvatar(child: Icon(Icons.account_circle)),
        title: Text(
          "${data["data"]["firstName"]} ${data["data"]["lastName"]}",
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: const Text("Has created an account"),
      ),
    );
  }
}
