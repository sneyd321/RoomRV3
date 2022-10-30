import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/services/notification.dart';
import 'package:notification_app/services/notification/download_lease_notification.dart';
import 'package:notification_app/services/notification/lease_complete_notification.dart';
import 'package:notification_app/services/notification/lease_connection_notification.dart';
import 'package:notification_app/services/notification/lease_upload_notification.dart';

import '../business_logic/comment.dart';

class FirebaseConfiguration {
  static final FirebaseConfiguration _singleton =
      FirebaseConfiguration._internal();

  factory FirebaseConfiguration() {
    return _singleton;
  }

  FirebaseConfiguration._internal();
  LocalNotificationService notificationService = LocalNotificationService();
  LeaseConnectionNotification leaseConnectionNotification =
      LeaseConnectionNotification();
  LeaseUploadNotification leaseUploadNotification = LeaseUploadNotification();
  LeaseCompleteNotification leaseCompleteNotification =
      LeaseCompleteNotification();
  DownloadLeaseNotification downloadLeaseNotification = DownloadLeaseNotification();

  void initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    notificationService.intialize();
    leaseUploadNotification.initialize();
    leaseConnectionNotification.initialize();
    leaseCompleteNotification.initialize();
    downloadLeaseNotification.initialize();

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    
    FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification!.title! == "Lease Generation") {
        switch (message.notification!.body!) {
          case "Lease uploading...":
            await leaseUploadNotification.showNotification();
            break;
          case "Lease Complete":
            await leaseCompleteNotification.showNotification(message.data["Lease"].toString());
            break;
        }
      }
    });
  }

  FirebaseFirestore getDB() {
    return FirebaseFirestore.instance;
  }

  Future<void> setComment(String firebaseId, Comment comment) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("MaintenanceTicket")
        .doc(firebaseId)
        .collection("Comment")
        .doc();
    documentReference.set(comment.toJson());
  }

  Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
