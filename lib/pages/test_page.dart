import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord.dart';

import 'package:notification_app/widgets/builders/notifications_limit.dart';

import '../business_logic/house.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  House house = House();
  List<Widget> widgets = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    house.houseId = 5;
   house.firebaseId = "TwIeQHeMqZMia0FAV7vm";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationLimit(house: house, landlord: Landlord())
    );
  }
}
