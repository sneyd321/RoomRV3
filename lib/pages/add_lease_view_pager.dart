import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'add_lease_pages/add_rent_page.dart';
import 'add_lease_pages/add_rental_address_page.dart';
import 'add_lease_pages/add_tenancy_terms_page.dart';

class AddLeaseViewPager extends StatefulWidget {
  final Landlord landlord;
  const AddLeaseViewPager({Key? key, required this.landlord}) : super(key: key);

  @override
  State<AddLeaseViewPager> createState() => _AddLeaseViewPagerState();
}

class _AddLeaseViewPagerState extends State<AddLeaseViewPager> {
  final PageController controller = PageController();
  int currentPage = 0;
  static const int MAX_PAGE = 2;
  String title = "Landlord Info";
  Map titleMapping = {
    0: "Rental Address",
    1: "Rent",
    2: "Tenancy Terms",
  };

  final Lease lease = Lease();

  @override
  void initState() {
    super.initState();
    lease.landlordInfo.fullName = widget.landlord.getFullName();
    lease.landlordInfo.addEmail(widget.landlord.email);
    lease.landlordInfo.addContactInfo(widget.landlord.email);
    lease.landlordInfo.addContactInfo(widget.landlord.phoneNumber);
    lease.rent.rentMadePayableTo = widget.landlord.getFullName();
    lease.rent.paymentOptions.add(ETransferPaymentOption());
    lease.rent.paymentOptions.add(PostDatedChequesPaymentOption());
    lease.rent.paymentOptions.add(CashPaymentOption());
    lease.rent.addRentService(CustomRentService("Parking", "0.00"));
 
  }


  void animateToPage(int currentPage) {
    controller.animateToPage(currentPage,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    setState(() {
      title = titleMapping[currentPage];
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }



  void onNext(BuildContext context) {
    if (currentPage < MAX_PAGE) {
      currentPage += 1;
    }

    animateToPage(currentPage);
  }

  void onBack(BuildContext context) {
    if (currentPage <= 0) {
      Navigator.pop(context);
      return;
    }
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
                        landlord: widget.landlord,
                        lease: lease,
                        onBack: onBack,
                      ),
                    ],
                  ),
                ),
              ])),
    );
  }
}
