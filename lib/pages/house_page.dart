import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/pages/add_lease_pages/add_landlord_address_page.dart';
import 'package:notification_app/pages/add_lease_pages/add_landlord_info_page.dart';
import 'package:notification_app/pages/graphql_page.dart';

import 'package:notification_app/services/FirebaseConfig.dart';

class HousesPage extends StatefulWidget {
  const HousesPage({Key? key}) : super(key: key);

  @override
  State<HousesPage> createState() => _HousesPageState();
}

class _HousesPageState extends State<HousesPage> {
  final FirebaseConfiguration firebaseConfiguration = FirebaseConfiguration();
  String text = "";
  List<House> houses = [];
  Lease lease = Lease();

  @override
  void initState() {
    super.initState();
    firebaseConfiguration.initialize();
    lease.services[0].addDetail("gdafdasfasf");
  }

  final GlobalKey<FormState> rentFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GraphQLPage();
  }
}
