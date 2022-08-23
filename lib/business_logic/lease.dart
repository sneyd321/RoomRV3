

import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/landlord_info.dart';
import 'package:notification_app/business_logic/list_items/additional_term.dart';
import 'package:notification_app/business_logic/list_items/deposit.dart';
import 'package:notification_app/business_logic/list_items/rent_discount.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/business_logic/list_items/tenant_name.dart';
import 'package:notification_app/business_logic/list_items/utility.dart';
import 'package:notification_app/business_logic/rent.dart';
import 'package:notification_app/business_logic/tenancy_terms.dart';

class Lease {
  String documentName = "2229E Residential Tenancy Agreement";
  String? documentURL;
  int leaseId = 0;
  int houseId = 0;
  LandlordInfo landlordInfo = LandlordInfo();
  LandlordAddress landlordAddress = LandlordAddress();
  RentalAddress rentalAddress = RentalAddress();
  Rent rent = Rent();
  TenancyTerms tenancyTerms = TenancyTerms();
  List<Service> services = [
    GasService(),
    AirConditioningService(),
    AdditionalStorageSpace(),
    OnSiteLaundry(),
    GuestParking()
  ];
  List<Utility> utilities = [
    ElectricityUtility(),
    HeatUtility(),
    WaterUtility(),
    InternetUtility()
  ];
  List<RentDiscount> rentDiscounts = [];
  List<Deposit> rentDeposits = [KeyDeposit(), PetDamageDeposit(), MaintenanceDeductableDeposit()];
  List<AdditionalTerm> additionalTerms = [
    PostDatedChequesTerm(),
    TenantInsuranceTerm(),
    PhotoIdentificationTerm(),
    CriminalRecordTerm(),
    NeverEvictedTerm(),
    NoSubletTerm(),
    NoAirBnBTerm(),
    CondominiumRulesTerm(),
    NoSmokingTerm(),
    CannabisTerm(),
    PaintingTerm(),
    InteriorMaintenanceTerm(),
    PromptNoticeTerm(),
    DrainCleanTerm(),
    ApplianceInGoodWorkingOrderTerm(),
    PropertyCleaningTerm(),
    TenantAbsenceTerm(),
    TwentyFourHourNoticeTerm(),
    MoveInWalkThroughTerm(),
    MoveOutWalkThroughTerm(),
    EndOfLeaseTerm(),
    PropertyShowingTerm()
  ];
  List<TenantName> tenantNames = [];

  Lease();
  
  Map<String, dynamic> toJson() {
    return {
      "landlordInfo": landlordInfo.toJson(),
      "landlordAddress": landlordAddress.toJson(),
      "rentalAddress": rentalAddress.toJson(),
      "rent": rent.toJson(),
      "tenancyTerms":tenancyTerms.toJson(),
      "services": services.map((service) => service.toJson()).toList(),
      "utilities": utilities.map((utility) => utility.toJson()).toList(),
      "rentDiscounts": rentDiscounts.map((rentDiscount) => rentDiscount.toJson()).toList(),
      "rentDeposits": rentDeposits.map((rentDeposit) => rentDeposit.toJson()).toList(),
      "additionalTerms": additionalTerms.map((additionalTerm) => additionalTerm.toJson()).toList(),
      "tenantNames": tenantNames.map((tenantName) => tenantName.toJson()).toList(),
    };
  }

}