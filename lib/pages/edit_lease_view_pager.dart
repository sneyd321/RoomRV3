
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/pages/edit_lease_pages/update_additional_terms_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_landlord_address_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_landlord_info_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_deposit_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_discount_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rental_address_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_services_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_tenancy_terms_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_tenant_names_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_utilities_page.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/services/notification/lease_connection_notification.dart';
import 'package:notification_app/widgets/mutations/generate_lease_mutation.dart';


class EditLeaseStatePager extends StatefulWidget {
  final House house;
  const EditLeaseStatePager({Key? key, required this.house}) : super(key: key);

  @override
  State<EditLeaseStatePager> createState() => _EditLeaseStatePagerState();
}

class _EditLeaseStatePagerState extends State<EditLeaseStatePager> {

  onUpdate(BuildContext context) {}

  


 

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: DefaultTabController(
          length: 11,
          child: Scaffold(
              appBar: AppBar(
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
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
                          Tab(icon: Icon(Icons.group)),
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
                      UpdateLandlordInfoPage(
                          onUpdate: onUpdate, lease: widget.house.lease),
                      UpdateLandlordAddressPage(
                        onUpdate: onUpdate,
                        lease: widget.house.lease,
                      ),
                      UpdateRentalAddressPage(
                          onUpdate: onUpdate, lease: widget.house.lease),
                      UpdateRentPage(onUpdate: onUpdate, lease: widget.house.lease),
                      UpdateTenancyTermsPage(
                          onUpdate: onUpdate, lease: widget.house.lease),
                      UpdateServicesPage(onUpdate: onUpdate, lease: widget.house.lease),
                      UpdateUtilityPage(onUpdate: onUpdate, lease: widget.house.lease),
                      UpdateRentDiscountPage(
                          onUpdate: onUpdate, lease: widget.house.lease),
                      UpdateRentDepositPage(
                          onUpdate: onUpdate, lease: widget.house.lease),
                      UpdateAdditionalTermsPage(
                          onUpdate: onUpdate, lease: widget.house.lease),
                      UpdateTenantNamesPage(
                          onUpdate: onUpdate, lease: widget.house.lease)
                    ],
                  ),
                ),
                 GenerateLeaseMutation(houseId: widget.house.houseId, lease: widget.house.lease, firebaseId: widget.house.firebaseId, onComplete: (BuildContext context, int houseId) async { 
                  //LeaseConnectionNotification leaseConnectionNotification = LeaseConnectionNotification();
                  //leaseConnectionNotification.showNotification();
                 },)
                
              ]))),
    );
  }
}
