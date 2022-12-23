import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/services/network.dart';
import 'package:notification_app/services/notification/download_lease_notification.dart';
import 'package:notification_app/widgets/Helper/TextHelper.dart';
import 'package:notification_app/widgets/buttons/SecondaryActionButton.dart';

class LeaseCompleteCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final IconData icon;
  const LeaseCompleteCard(
      {Key? key, required this.notification, required this.icon})
      : super(key: key);

  String parseTimestamp(Timestamp timestamp) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    return dateFormat.format(timestamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Container(
              height: 46,
              width: 46,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
              alignment: Alignment.center,
            ),
            title: TextHelper(text: notification["body"]),
            subtitle: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Text(
                  "Created on: ${parseTimestamp(notification["dateCreated"])}"),
            ),
          ),
          SecondaryActionButton(text: "Open Lease", onClick: () async {
            Network network = Network();
            DownloadLeaseNotification downloadLeaseNotification =
                DownloadLeaseNotification();
            downloadLeaseNotification.showNotification();
            String filePath = await network.downloadFromURL(
                notification["data"]["link"], "Lease.pdf");
            await downloadLeaseNotification.localNotificationService.cancel(0);
            network.openFile(filePath);
          })
        ],
      ),
    );
  }
}
