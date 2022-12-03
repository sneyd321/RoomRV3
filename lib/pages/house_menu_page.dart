import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/pages/edit_lease_view_pager.dart';
import 'package:notification_app/pages/notification_page.dart';
import 'package:notification_app/widgets/Cards/AddTenantCard.dart';
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
                body: ListView(children: [
                  Hero(
                    tag: widget.house.houseKey,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/house.jpg"),
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                              height: 300,
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        "House Key: ${widget.house.houseKey}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    parsePrimaryAddress(widget.house),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    parseSecondaryAddress(widget.house),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, left: 8, right: 8),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditLeaseStatePager(
                                                            house: widget.house)),
                                              );
                                            },
                                            child: Column(children: [
                                              const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.assignment,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.all(8),
                                                child: const Text(
                                                  "View Lease",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ]),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              const snackBar = SnackBar(
                                                content: Text(
                                                    'TODO: Not implemented as part of current release'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            },
                                            child: Column(
                                              children: [
                                                const CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.payment,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.all(8),
                                                  child: const Text(
                                                    "View Payments",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NotificationPage(
                                                          house: widget.house,
                                                          landlord:
                                                              widget.landlord,
                                                        )),
                                              );
                                            }),
                                            child: Column(
                                              children: [
                                                const CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.notifications,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.all(8),
                                                  child: const Text(
                                                    "Notifications",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ]),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  QueryHelper(
                      isList: true,
                      variables: {"houseId": widget.house.houseId},
                      queryName: "getTenants",
                      onComplete: (json) {
                        if (json.length != (tenantWidgets.length - 1)) {
                          List<Tenant> tenants = json
                              .map<Tenant>(
                                  (tenantJson) => Tenant.fromJson(tenantJson))
                              .toList();
                          tenantWidgets = [];
                          tenantWidgets = tenants.map<Widget>((tenant) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: AddTenantCard(
                                            houseKey: widget.house.houseKey,
                                            tenant: tenant,
                                            onDeleteTenant: (tenant) {},
                                          ),
                                        );
                                      });
                                },
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(
                                        Icons.account_circle,
                                        size: 60,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      child: Text(
                                        tenant.getFullName(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList();
                          tenantWidgets.add(
                            GestureDetector(
                              onTap: () async {
                                Tenant? tenant =
                                    await BottomSheetHelper<Tenant?>(
                                            AddTenantEmailForm(
                                                houseId: widget.house.houseId))
                                        .show(context);
                                if (tenant == null) {
                                  return;
                                }
                                setState(() {});
                              },
                              child: Container(
                               
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(
                                        Icons.add,
                                        size: 40,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      child: const Text(
                                        "Add Tenant",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Wrap(
                              alignment: WrapAlignment.start,
                              children: tenantWidgets),
                        );
                      }),
                  NotificationLimit(
                      house: widget.house, landlord: widget.landlord),
                  GestureDetector(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage(
                                  house: widget.house,
                                  landlord: widget.landlord,
                                )),
                      );
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
                ]))));
  }
}
