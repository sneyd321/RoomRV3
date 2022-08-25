import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/pages/add_lease_pages/add_landlord_info_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'add_lease_pages/add_additional_terms_page.dart';
import 'add_lease_pages/add_landlord_address_page.dart';
import 'add_lease_pages/add_rent_deposit_page.dart';
import 'add_lease_pages/add_rent_discount_page.dart';
import 'add_lease_pages/add_rent_page.dart';
import 'add_lease_pages/add_rental_address_page.dart';
import 'add_lease_pages/add_services_page.dart';
import 'add_lease_pages/add_tenancy_terms_page.dart';
import 'add_lease_pages/add_tenant_names_page.dart';
import 'add_lease_pages/add_utilities_page.dart';

class AddLeaseViewPager extends StatefulWidget {
  const AddLeaseViewPager({Key? key}) : super(key: key);

  @override
  State<AddLeaseViewPager> createState() => _AddLeaseViewPagerState();
}

class _AddLeaseViewPagerState extends State<AddLeaseViewPager> {
  final PageController controller = PageController();
  int currentPage = 0;
  static const int MAX_PAGE = 10;
  String title = "Landlord Info";
  Map titleMapping = {
    0: "Landlord Info",
    1: "Landlord Address",
    2: "Rental Address",
    3: "Rent",
    4: "Tenancy Terms",
    5: "Services",
    6: "Utilities",
    7: "Rent Discounts",
    8: "Deposit",
    9: "Additional Terms",
    10: "Tenant Names"
  };

  final Lease lease = Lease();

  void animateToPage(int currentPage) {
    controller.animateToPage(currentPage,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    setState(() {
      title = titleMapping[currentPage];
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void upload(BuildContext context) {}

  void onNext(BuildContext context) {
    if (currentPage < MAX_PAGE) {
      currentPage += 1;
    }

    animateToPage(currentPage);
  }

  void onBack(BuildContext context) {
    if (currentPage <= 0) {}

    currentPage -= 1;
    animateToPage(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                child: SmoothPageIndicator(
                  controller: controller,
                  count: MAX_PAGE + 1,
                  effect: const WormEffect(),
                ),
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    AddTenantNamesPage(
                        onNext: (context) {
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        },
                        onBack: onBack,
                        lease: lease),
                    AddLandlordInfoPage(
                      lease: lease,
                      onNext: onNext,
                      onBack: onBack,
                    ),
                    AddLandlordAddressPage(
                      lease: lease,
                      onNext: onNext,
                      onBack: onBack,
                    ),
                    AddRentalAddressPage(
                      lease: lease,
                      onNext: onNext,
                      onBack: onBack,
                    ),
                    AddRentPage(
                      lease: lease,
                      onNext: onNext,
                      onBack: onBack,
                    ),
                    AddTenancyTermsPage(
                      lease: lease,
                      onNext: onNext,
                      onBack: onBack,
                    ),
                    AddServicesPage(
                        onNext: onNext, onBack: onBack, lease: lease),
                    AddUtilityPage(
                        onNext: onNext, onBack: onBack, lease: lease),
                    AddRentDiscountPage(
                        onNext: onNext, onBack: onBack, lease: lease),
                    AddRentDepositPage(
                        onNext: onNext, onBack: onBack, lease: lease),
                    AddAdditionalTermsPage(
                        onNext: onNext, onBack: onBack, lease: lease),
                  ],
                ),
              ),
            ])));
  }
}
