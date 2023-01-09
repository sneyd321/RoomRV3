import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/landlord_info.dart';
import 'package:notification_app/business_logic/list_items/additional_term.dart';
import 'package:notification_app/business_logic/list_items/deposit.dart';
import 'package:notification_app/business_logic/list_items/rent_discount.dart';
import 'package:notification_app/business_logic/list_items/rent_services.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/business_logic/list_items/utility.dart';
import 'package:notification_app/business_logic/rent.dart';
import 'package:notification_app/business_logic/tenancy_terms.dart';

class Lease {
  String documentName = "2229E Residential Tenancy Agreement";
  String? documentURL;
  int leaseId = 0;
  LandlordInfo landlordInfo = LandlordInfo();
  RentalAddress rentalAddress = RentalAddress();
  Rent rent = Rent();
  TenancyTerms tenancyTerms = TenancyTerms();
  List<Service> services = [];
  List<Utility> utilities = [
    ElectricityUtility(),
    HeatUtility(),
    WaterUtility(),
    InternetUtility()
  ];
  List<RentDiscount> rentDiscounts = [];
  List<Deposit> rentDeposits = [
    KeyDeposit(),
    PetDamageDeposit(),
    MaintenanceDeductableDeposit()
  ];
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
  final List<String> requiredServices = const [
    "gas",
    "air conditioning",
    "additional storage space",
    "on-site laundry",
    "guest parking",
    "parking"
  ];
  final List<String> requiredUtilities = const [
    "electricity",
    "heat",
    "water",
    "internet"
  ];

  Lease();

  Lease.fromJson(Map<String, dynamic> json) {
    leaseId = json["id"];
    documentName = json["documentName"];
    documentURL = json["documentURL"];
    landlordInfo = LandlordInfo.fromJson(json["landlordInfo"]);
    rentalAddress = RentalAddress.fromJson(json["rentalAddress"]);
    rent = Rent.fromJson(json["rent"]);
    tenancyTerms = TenancyTerms.fromJson(json["tenancyTerms"]);
    services = json["services"]
        .map<PayPerUseService>(
            (serviceJson) => CustomService.fromJson(serviceJson))
        .toList();
    utilities = json["utilities"]
        .map<Utility>((utilityJson) => CustomUtility.fromJson(utilityJson))
        .toList();
    rentDiscounts = json["rentDiscounts"]
        .map<RentDiscount>(
            (rentDiscountJson) => CustomRentDiscount.fromJson(rentDiscountJson))
        .toList();
    rentDeposits = json["rentDeposits"]
        .map<Deposit>(
            (rentDepositJson) => CustomDeposit.fromJson(rentDepositJson))
        .toList();
    additionalTerms = json["additionalTerms"]
        .map<AdditionalTerm>(
            (additionalTermJson) => CustomTerm.fromJson(additionalTermJson))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "landlordInfo": landlordInfo.toJson(),
      "rentalAddress": rentalAddress.toJson(),
      "rent": rent.toJson(),
      "tenancyTerms": tenancyTerms.toJson(),
      "services": services.map((service) => service.toJson()).toList(),
      "utilities": utilities.map((utility) => utility.toJson()).toList(),
      "rentDiscounts":
          rentDiscounts.map((rentDiscount) => rentDiscount.toJson()).toList(),
      "rentDeposits":
          rentDeposits.map((rentDeposit) => rentDeposit.toJson()).toList(),
      "additionalTerms": additionalTerms
          .map((additionalTerm) => additionalTerm.toJson())
          .toList(),
    };
  }

  void addRequiredServices() {
    for (String serviceName in requiredServices) {
      switch (serviceName) {
        case "gas":
          services.add(GasService());
          continue;
        case "air conditioning":
          services.add(AirConditioningService());
          continue;
        case "additional storage space":
          services.add(AdditionalStorageSpace());
          continue;
        case "on-site laundry":
          services.add(OnSiteLaundry());
          continue;
        case "guest parking":
          services.add(GuestParking());
          continue;
      }
    }
  }

  void addRequiredUtilities() {
    for (String utilityName in requiredUtilities) {
      switch (utilityName) {
        case "electricity":
          utilities.add(InternetUtility());
          continue;
        case "heat":
          utilities.add(HeatUtility());
          continue;
        case "water":
          utilities.add(WaterUtility());
          continue;
        case "internet":
          utilities.add(InternetUtility());
          continue;
      }
    }
  }

  void filterRequiredServices() {
    rent.rentServices.removeWhere((RentService rentService) =>
        requiredServices.contains(rentService.name.toLowerCase()));
  }

  void filterRequiredUtilities() {
    rent.rentServices.removeWhere((RentService rentService) =>
        requiredUtilities.contains(rentService.name.toLowerCase()));
  }

  void parseServicesFromRentServices() {
    for (RentService rentService in rent.rentServices) {
      PayPerUseService service = CustomService(rentService.name);
      service.isPayPerUse = rentService.amount != "0.00";
      service.isIncludedInRent = true;
      services.add(service);
    }
  }

  void parseUtilitiesFromRentServices() {
    for (RentService rentService in rent.rentServices) {
      String name = rentService.name.toLowerCase();
      Utility utility = CustomUtility(rentService.name);
      utility.addDetail(
          "Tenant sets up account with $name provider and pays the utiltiy provider");
      utility.addDetail("Tenant pays a portion of the $name costs");
      utility.addDetail(
          "Tenant agrees to pay the cost of $name required in the premises and the extention thereof");
      utility.addDetail(
          "Tenant further agrees to provide proof to the Landlord on or before the date of possession that the service has been transferred to the Tenant's name.");
      utilities.add(utility);
    }
  }
}
