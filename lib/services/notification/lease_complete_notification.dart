import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_app/services/network.dart';
import 'package:notification_app/services/notification/download_lease_notification.dart';

class LeaseCompleteNotification {
  final localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_stat_assignment');

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await localNotificationService.initialize(
      settings,
      onSelectNotification: (payload) {
        print("**************");
      },
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification(String payload) async {
    final details = await _notificationDetails();
    await localNotificationService.show(
        0, "Lease Generation", "Upload complete. Tap to download", details,
        payload: payload);
    Network network = Network();
    DownloadLeaseNotification downloadLeaseNotification =
        DownloadLeaseNotification();
    downloadLeaseNotification.showNotification();
    String filePath = await network.downloadFromURL(payload, "Lease.pdf");
    await localNotificationService.cancel(0);
    print(filePath);
    network.openFile(filePath);
  }
}
