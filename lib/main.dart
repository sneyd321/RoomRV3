import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/pages/add_lease_pages/add_lease_signiture_page.dart';
import 'package:notification_app/pages/comments_page.dart';
import 'package:notification_app/pages/house_page.dart';
import 'package:notification_app/pages/landlord_view_pager.dart';
import 'package:notification_app/pages/login_page.dart';
import 'package:notification_app/pages/sign_up_page.dart';
import 'package:notification_app/services/FirebaseConfig.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyBxpgJlnz2e5NV03gFfDQQjd0NVv8RvD0w',
    appId: '1:959426188245:android:32150f37668273de50a35c',
    messagingSenderId: '959426188245',
    projectId: 'roomr-222721',
    databaseURL: 'https://roomr-222721.firebaseio.com',
    storageBucket: 'roomr-222721.appspot.com',
  ));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/":(context) => CommentsPage(maintenanceTicketId: 40, houseKey: "Z14M4C", landlord: Landlord(),),
      },
    );
  }
}

