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

import '../services/graphql_client.dart';


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
          ]))),
    );
  }
}
