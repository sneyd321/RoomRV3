import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/payment_option.dart';
import 'package:notification_app/business_logic/list_items/rent_services.dart';

void main() {
  test("Verify services are allocated from rent services", () {
    Lease lease = Lease();
    lease.landlordInfo.fullName = "";
    lease.landlordInfo.addEmail("widget.landlord.email");
    lease.landlordInfo.addContactInfo("widget.landlord.email");
    lease.landlordInfo.addContactInfo("widget.landlord.phoneNumber");
    lease.rent.rentMadePayableTo = "widget.landlord.getFullName()";
    lease.rent.paymentOptions.add(ETransferPaymentOption());
    lease.rent.paymentOptions.add(PostDatedChequesPaymentOption());
    lease.rent.paymentOptions.add(CashPaymentOption());
    lease.rent.addRentService(CustomRentService("Gas", "0.00"));
    lease.rent.addRentService(CustomRentService("Air conditioning", "0.00"));
    lease.rent.addRentService(CustomRentService("Additional storage space", "0.00"));
    lease.rent.addRentService(CustomRentService("On-site Laundry", "0.00"));
    lease.rent.addRentService(CustomRentService("Guest Parking", "0.00"));
    lease.rent.addRentService(CustomRentService("Electricity", "0.00"));
    lease.rent.addRentService(CustomRentService("Heat", "0.00"));
    lease.rent.addRentService(CustomRentService("Water", "0.00"));
    lease.rent.addRentService(CustomRentService("Internet", "0.00"));
    lease.parseServicesFromRentServices();
    expect(lease.services.length, 5);
    
  });


}