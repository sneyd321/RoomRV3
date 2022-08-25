import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/widgets/Cards/HouseCard.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord_info.dart';
import 'package:notification_app/business_logic/partial_period.dart';
import 'package:notification_app/business_logic/rent.dart';
import 'package:notification_app/business_logic/tenancy_terms.dart';
import 'package:notification_app/pages/add_lease_view_pager.dart';
import 'package:notification_app/pages/house_menu_page.dart';
import 'package:notification_app/pages/house_page.dart';
import 'package:notification_app/services/FirebaseConfig.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LandlordInfo()),
        ChangeNotifierProvider(create: (context) => LandlordAddress()),
        ChangeNotifierProvider(create: (context) => RentalAddress()),
        ChangeNotifierProvider(create: (context) => Rent()),
        ChangeNotifierProvider(create: (context) => TenancyTerms()),
        ChangeNotifierProvider(create: (context) => PartialPeriod()),
      ],
    child: const MyApp()));
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
        "/":(context) => const HousesPage(houses: []),
        "/AddLeaseViewPager": (context) => const AddLeaseViewPager()
      },
    );
  }
}

