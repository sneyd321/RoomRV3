import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/widgets/Cards/ApproveTenantNotification.dart';
import 'package:notification_app/widgets/FormFields/SimpleFormField.dart';
import 'package:notification_app/widgets/Navigation/bottom_nav_bar.dart';

import '../business_logic/fields/field.dart';
import '../business_logic/house.dart';
import '../business_logic/maintenance_ticket_notification.dart';
import '../widgets/Cards/InviteTenantNotificationCard.dart';
import '../widgets/Cards/TenantAccountCreatedNotification.dart';
import '../widgets/Cards/download_lease_notification.dart';
import '../widgets/Cards/maintenance_ticket_card.dart';
import '../widgets/Listviews/CardSliverListView.dart';
import '../widgets/builders/notification_stream_builder.dart';

class NotificationPage extends StatefulWidget {
  final House house;
  final Landlord landlord;

  const NotificationPage(
      {Key? key, required this.house, required this.landlord})
      : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final TextEditingController searchTextEditingController =
      TextEditingController();
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            bottomNavigationBar: BottomNavBar(landlord: widget.landlord,),
            body: ListView(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: const Text(
                        "Notifications",

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      ),
                    )),
                    Flexible(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: TextField(
                          controller: searchTextEditingController,
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45.0),
                              ),
                              filled: true,
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: (() {
                                  setState(() {
                                    searchTextEditingController.text = "";
                                    searchText = "";
                                  });
                                }),
                              ),
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Search Keywords",
                              fillColor: Colors.white70),
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('House')
                      .doc(widget.house.firebaseId)
                      .collection("Landlord")
                      .orderBy("dateCreated", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<QueryDocumentSnapshot> queryDocumentSnapshots =
                        snapshot.data!.docs;
                    if (searchText.isNotEmpty) {
                      queryDocumentSnapshots =
                          queryDocumentSnapshots.where((element) {
                        return element
                            .data()
                            .toString()
                            .toLowerCase()
                            .contains(searchText.toLowerCase());
                      }).toList();
                    }

                    return CardSliverListView(
                      shrinkWrap: true,
                      items: queryDocumentSnapshots,
                      builder: (context, index) {
                        QueryDocumentSnapshot document =
                            queryDocumentSnapshots[index];
                        switch (document.get("Name")) {
                          case "MaintenanceTicket":
                            return MaintenanceTicketNotificationCard(
                              landlord: widget.landlord,
                              document: document,
                            );
                          case "DownloadLease":
                            return DownloadLeaseNotificationCard(
                              document: document,
                            );
                          case "InvitePendingTenant":
                            return InviteTenantNotificationCard(
                                document: document);
                          case "TenantAccountCreated":
                            return TenantAccountCreatedNotification(
                                document: document);
                          case "ApproveTenant":
                            return ApproveTenantNotificationCard(
                                document: document);
                          default:
                            return Text(
                                "TODO: Make notification for event: ${document.get("Name")}");
                        }
                      },
                      controller: ScrollController(),
                    );
                  },
                ),
              ],
            )));
  }
}
