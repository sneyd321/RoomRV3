import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/pages/edit_lease_view_pager.dart';
import 'package:notification_app/pages/navigation.dart';
import 'package:notification_app/pages/notification_page.dart';
import 'package:notification_app/widgets/Buttons/IconTextColumn.dart';
import 'package:notification_app/widgets/Buttons/TenantRow.dart';
import 'package:notification_app/widgets/Cards/AddTenantCard.dart';
import 'package:notification_app/widgets/Cards/HouseCard.dart';
import 'package:notification_app/widgets/Navigation/bottom_nav_bar.dart';
import 'package:notification_app/widgets/builders/notification_stream_builder.dart';
import 'package:notification_app/widgets/builders/notifications_limit.dart';

import '../business_logic/address.dart';
import '../business_logic/maintenance_ticket_notification.dart';
import '../business_logic/tenant.dart';
import '../graphql/graphql_client.dart';
import '../graphql/query_helper.dart';
import '../widgets/Cards/ApproveTenantNotification.dart';
import '../widgets/Cards/InviteTenantNotificationCard.dart';
import '../widgets/Cards/TenantAccountCreatedNotification.dart';
import '../widgets/Cards/download_lease_notification.dart';
import '../widgets/Cards/maintenance_ticket_card.dart';
import '../widgets/Forms/BottomSheetForm/AddTenantForm.dart';
import '../widgets/Helper/BottomSheetHelper.dart';
import '../widgets/Listviews/CardSliverListView.dart';

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
                bottomNavigationBar: const BottomNavBar(),
                appBar: AppBar(
                  backgroundColor: Colors.black,
                ),
                body: ListView(
                  shrinkWrap: true,
                  children: [
                    HouseCard(
                        house: widget.house,
                        landlord: widget.landlord,
                        onHouse: (house, landlord) {},
                        height: 300,
                        children: [
                          IconTextColumn(
                              icon: Icons.assignment,
                              text: "View Lease",
                              profileSize: 24,
                              iconSize: 24,
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditLeaseStatePager(
                                            house: widget.house,
                                          )),
                                );
                              }),
                          IconTextColumn(
                              icon: Icons.payment,
                              text: "View Payments",
                              profileSize: 24,
                              iconSize: 24,
                              onClick: () {
                                const snackBar = SnackBar(
                                  content: Text(
                                      'TODO: Not implemented as part of current release'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }),
                          IconTextColumn(
                              icon: Icons.notifications,
                              text: "Notifications",
                              profileSize: 24,
                              iconSize: 24,
                              onClick: () {
                                Navigation().navigateToNotificationsPage(
                                    context, widget.house, widget.landlord);
                              }),
                        ]),
                        TenantRow(house: widget.house),
                    NotificationLimit(
                        house: widget.house, landlord: widget.landlord),
                    GestureDetector(
                      onTap: (() {
                        Navigation().navigateToNotificationsPage(context, widget.house, widget.landlord);
                      }),
                      child: Container(
                        margin:
                            const EdgeInsets.only(bottom: 8, left: 8, right: 8),
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
                )));
  }
}
