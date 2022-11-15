import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/comment.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/firebase_options.dart';
import 'package:notification_app/pages/add_lease_pages/add_lease_signiture_page.dart';
import 'package:notification_app/pages/add_tenant_page.dart';
import 'package:notification_app/pages/maintenance_ticket_pages/comments_page.dart';
import 'package:notification_app/pages/house_page.dart';
import 'package:notification_app/pages/landlord_view_pager.dart';
import 'package:notification_app/pages/login_page.dart';
import 'package:notification_app/pages/sign_up_page.dart';
import 'package:notification_app/pages/test_page.dart';
import 'package:notification_app/services/FirebaseConfig.dart';

import 'business_logic/house.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseConfiguration().initialize();
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
        "/":(context) =>  const LoginPage(email: "", password: "",)
      },
    );
  }
}

