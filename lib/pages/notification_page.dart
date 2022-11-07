import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord.dart';

import '../business_logic/house.dart';
import '../widgets/builders/notification_stream_builder.dart';

class NotificationPage extends StatelessWidget {
  final List<House> houses;
  final Landlord landlord;
  const NotificationPage({Key? key, required this.houses, required this.landlord})
      : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: Container(
              height: 60,
              margin: const EdgeInsets.only(bottom: 16),
            ),
            body: NotificationStreamBuilder(houses: houses, landlord: landlord,)));
  }
}
