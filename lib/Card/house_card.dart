import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/house.dart';

class HouseCard extends StatelessWidget {
  final House house;
  const HouseCard({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    house.houseKey = "a34fd3";
    return Card(
      child: Image.network(
          "https://storage.googleapis.com/roomr-222721.appspot.com/istockphoto-1323734048-170667a.jpg"),
    );
  }
}
