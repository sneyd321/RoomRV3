import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/widgets/Navigation/navigation.dart';
import 'package:notification_app/widgets/Buttons/TenantRow.dart';
import 'package:notification_app/widgets/Cards/HouseMenuCard.dart';
import 'package:notification_app/widgets/Navigation/bottom_nav_bar.dart';
import 'package:notification_app/widgets/builders/notifications_limit.dart';

import '../business_logic/address.dart';
import '../graphql/graphql_client.dart';

class HouseMenuPage extends StatefulWidget {
  final House house;
  final Landlord landlord;
  const HouseMenuPage({Key? key, required this.house, required this.landlord})
      : super(key: key);

  @override
  State<HouseMenuPage> createState() => _HouseMenuPageState();
}

class _HouseMenuPageState extends State<HouseMenuPage> {
  List<Widget> tenantWidgets = [];

  String parsePrimaryAddress(House house) {
    RentalAddress rentalAddress = house.lease.rentalAddress;
    String streetNumber = rentalAddress.streetNumber;
    String streetName = rentalAddress.streetName;
    return "$streetNumber $streetName";
  }

  String parseSecondaryAddress(House house) {
    RentalAddress rentalAddress = house.lease.rentalAddress;
    String city = rentalAddress.city;
    String province = rentalAddress.province;
    String postalCode = rentalAddress.postalCode;
    return "$city, $province $postalCode";
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GQLClient().getClient(),
        child: SafeArea(
            child: Scaffold(
          bottomNavigationBar: BottomNavBar(
            landlord: widget.landlord,
          ),
          appBar: AppBar(
            backgroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Hero(
                  tag: widget.house.houseKey,
                  child: HouseMenuCard(
                    house: widget.house,
                    landlord: widget.landlord,
                  )),
              TenantRow(house: widget.house),
              NotificationLimit(house: widget.house, landlord: widget.landlord),
              GestureDetector(
                onTap: (() {
                  Navigation().navigateToNotificationsPage(
                      context, widget.house, widget.landlord);
                }),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  color: Colors.black,
                  height: 40,
                  child: const Center(
                      child: Text(
                    "View More Notifications",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              )
            ]),
          ),
        )));
  }
}
