import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/pages/edit_lease_pages/update_additional_terms_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_landlord_info_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_deposit_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_discount_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rental_address_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_services_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_tenancy_terms_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_utilities_page.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


import '../graphql/mutation_helper.dart';
import '../graphql/graphql_client.dart';
import '../widgets/buttons/CallToActionButton.dart';

class EditLeaseStatePager extends StatefulWidget {
  final House house;
  const EditLeaseStatePager({Key? key, required this.house}) : super(key: key);

  @override
  State<EditLeaseStatePager> createState() => _EditLeaseStatePagerState();
}

class _EditLeaseStatePagerState extends State<EditLeaseStatePager> {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: DefaultTabController(
          length: 9,
          child: MutationHelper(
              onComplete: (json) {
                const snackBar = SnackBar(
                  content: Text('Lease Revision Creating... You will recieve a notification when complete'),
                );


                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              mutationName: "scheduleLease",
              builder: (runMutation) {
                return Scaffold(
                    appBar: AppBar(
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const TabBar(
                              isScrollable: true,
                              tabs: [
                                Tab(icon: Icon(Icons.account_circle)),
                                Tab(icon: Icon(Icons.home)),
                                Tab(icon: Icon(Icons.monetization_on)),
                                Tab(icon: Icon(Icons.date_range)),
                                Tab(icon: Icon(Icons.home_repair_service)),
                                Tab(icon: Icon(Icons.electrical_services)),
                                Tab(icon: Icon(Icons.discount)),
                                Tab(
                                  icon: Icon(Icons.money),
                                ),
                                Tab(icon: Icon(Icons.assignment)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    body: Column(children: [
                      Expanded(
                        child: TabBarView(
                          children: [
                            UpdateLandlordInfoPage(house: widget.house),
                            UpdateRentalAddressPage(house: widget.house),
                            UpdateRentPage(house: widget.house),
                            UpdateTenancyTermsPage(house: widget.house),
                            UpdateServicesPage(house: widget.house),
                            UpdateUtilityPage(house: widget.house),
                            UpdateRentDiscountPage(house: widget.house),
                            UpdateRentDepositPage(house: widget.house),
                            UpdateAdditionalTermsPage(house: widget.house),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        child: CallToActionButton(
                            text: "Create New Revision",
                            onClick: () {
                              runMutation({
                                "houseKey": widget.house.houseKey,
                                "firebaseId": widget.house.firebaseId,
                                "signature": ""
                              });
                            }),
                      )
                    ]));
              })),
    );
  }
}
