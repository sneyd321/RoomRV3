import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/pages/edit_lease_pages/update_additional_terms_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_landlord_address_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_landlord_info_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_deposit_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_discount_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rental_address_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_services_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_tenancy_terms_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_utilities_page.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:signature/signature.dart';

import '../graphql/mutation_helper.dart';

class EditLeaseStatePager extends StatefulWidget {
  final House house;
  const EditLeaseStatePager({Key? key, required this.house}) : super(key: key);

  @override
  State<EditLeaseStatePager> createState() => _EditLeaseStatePagerState();
}

class _EditLeaseStatePagerState extends State<EditLeaseStatePager> {
  onUpdate(BuildContext context) {}
  final SignatureController controller =
      SignatureController(exportBackgroundColor: Colors.white);
  String signitureError = "";

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GQLClient().getClient(),
        child: MutationHelper(
          builder: (runMutation) {
            return DefaultTabController(
              length: 10,
              child: Scaffold(
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
                              Tab(icon: Icon(Icons.location_on)),
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
                          UpdateLandlordInfoPage(lease: widget.house.lease),
                          UpdateLandlordAddressPage(
                            lease: widget.house.lease,
                          ),
                          UpdateRentalAddressPage(lease: widget.house.lease),
                          UpdateRentPage(lease: widget.house.lease),
                          UpdateTenancyTermsPage(lease: widget.house.lease),
                          UpdateServicesPage(lease: widget.house.lease),
                          UpdateUtilityPage(lease: widget.house.lease),
                          UpdateRentDiscountPage(lease: widget.house.lease),
                          UpdateRentDepositPage(lease: widget.house.lease),
                          UpdateAdditionalTermsPage(lease: widget.house.lease),
                        ],
                      ),
                    ),
                    PrimaryButton(Icons.upload, "Generate Lease", (context) {
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                TextButton(
                                  child: const Text('Clear'),
                                  onPressed: () {
                                    controller.clear();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Generate'),
                                  onPressed: () async {
                                    if (controller.isEmpty) {
                                      setState(() {
                                        signitureError =
                                            "Please enter a signature";
                                      });
                                    }
                                    String base64EncodedSigniture =
                                        base64Encode(
                                            await controller.toPngBytes() ??
                                                []);
                                    runMutation({
                                      "signature": base64EncodedSigniture,
                                      "houseId": widget.house.houseId,
                                      "firebaseId": widget.house.firebaseId
                                    });
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                              content: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 400),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      child: ClipRRect(
                                        child: SizedBox(
                                          height: 125,
                                          child: Signature(
                                            controller: controller,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(signitureError,
                                              style: const TextStyle(
                                                  color: Colors.red))),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                     
                    })
                  ])),
            );
          },
          mutationName: 'scheduleLease',
          onComplete: (json) {},
        ));
  }
}
