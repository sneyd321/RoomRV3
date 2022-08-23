
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseConfiguration {

  static final FirebaseConfiguration _singleton = FirebaseConfiguration._internal();

  factory FirebaseConfiguration() {
    return _singleton;
  }

  FirebaseConfiguration._internal();

  void initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((message) async {
      print("FDSAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
    });
  }

  FirebaseFirestore getDB() {
    return FirebaseFirestore.instance;
  }

  Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}