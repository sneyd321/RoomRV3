
import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/detail.dart';

abstract class AdditionalTerm extends ChangeNotifier {
  String name = "";
  List<Detail> details = [];

  AdditionalTerm();

  AdditionalTerm.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    details = json["details"].map<Detail>((json) => Detail.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() =>
      {"name": name, "details": details.map((Detail detail) => detail.toJson()).toList()};

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void addDetail(String detail) {
    details.add(Detail(detail));
    notifyListeners();
  }
}

class CustomTerm extends AdditionalTerm {
  CustomTerm(String name) : super() {
    this.name = name;
  }
  CustomTerm.fromJson(Map<String, dynamic> json): super() {
     name = json["name"];
    details = json["details"].map<Detail>((json) => Detail.fromJson(json)).toList();
  }

}

class PostDatedChequesTerm extends AdditionalTerm {
  PostDatedChequesTerm() {
    name = "Post Dated Cheques";
    details.add(Detail("Tenant voluntarily agrees to provide 10 post-dated cheques to the Landlord on or before the commencement date of lease."));
  }
}

class KeyDepositTerm extends AdditionalTerm {
  KeyDepositTerm() {
    name = "Key Deposit";
    details.add(Detail("The Tenant agrees and understands that loss of any keys and/or passes to the said premises during the term of the Lease are to be replaced at his own expense."));
    details.add(Detail("The Tenant agrees to submit a \$300 refundable deposit to the Landlord for keys and remote(s)."));
  }
}

class TenantInsuranceTerm extends AdditionalTerm {
  TenantInsuranceTerm() {
    name = "Tenant Insurance";
    details.add(Detail("The Tenant acknowledges that the Landlord's Insurance provides no coverage on the tenant's personal property."));
    details.add(Detail("the Tenant agrees to carry contents insurance and provide the proof to the Landlord before or on the closing."));
  }
}

class PhotoIdentificationTerm extends AdditionalTerm {
  PhotoIdentificationTerm() {
    name = "Photo Identification";
    details.add(Detail("The Tenant agrees to provide photo identification for the purpose of verifying his identity for security purposes on or before the closing."));
  }
}

class CriminalRecordTerm extends AdditionalTerm {
  CriminalRecordTerm() {
    name = "Criminal Record";
    details.add(Detail("The Tenant warrants that he/she has never had a criminal record."));
  }
}

class NeverEvictedTerm extends AdditionalTerm {
  NeverEvictedTerm() {
    name = "Never Evicted";
    details.add(Detail("The Tenant warrants that he/she has never been evicted by the previous landlord."));
  }
}

class NoSubletTerm extends AdditionalTerm {
  NoSubletTerm() {
    name = "No Sublet";
    details.add(Detail("The Tenant shall not assign or Sub-Lease the subject property "));
  }
}

class NoAirBnBTerm extends AdditionalTerm {
  NoAirBnBTerm() {
    name = "No AirBnB";
    details.add(Detail("The Tenant shall not rent as AirBnB without the consent of the Landlord."));
  }
}

class CondominiumRulesTerm extends AdditionalTerm {
  CondominiumRulesTerm() {
    name = "Condominum Compliance";
    details.add(Detail("Tenant, occupants and visitors shall comply with all the By-laws of the Condominium Corporation"));
    details.add(Detail("The Landlord agrees to provide the Tenant the Condominium Corporation regulations, rules and by-law before the closing"));
  }
}

class NoSmokingTerm extends AdditionalTerm {
  NoSmokingTerm() {
    name = "Smoking";
    details.add(Detail("The Tenant, occupants and visitors agree that there is no smoking on this premises."));
  }
}

class PetDamageTerm extends AdditionalTerm {
  PetDamageTerm() {
    name = "Pet Damage";
    details.add(Detail("Tenant agrees to be responsible for any repair or replacement cost due to the presence of any pets on the premises."));
    details.add(Detail("Tenant shall, at lease termination, make any repairs that may be necessary to restore any damages caused by pets."));
    details.add(Detail("Tenant shall reimburse the Landlord for the cost of any repairs resulting from the damage."));
    details.add(Detail("The Tenant agrees to clean up after the pet so that there is no pet hair, urine, or feces remaining or visible anywhere in or on the Leased Premises and the building or common areas where the Leased Premises forms a part"));
    details.add(Detail("The Tenant shall keep the pet on a leash while the pet is in the common area of the building in which the Leased Premises forms a part. "));
    details.add(Detail("The Landlord shall keep \$250 security deposit from the reimbustment fund to the Tenant for the some of the cost of painting by the tenant."));
  }
}

class CannabisTerm extends AdditionalTerm {
  CannabisTerm() {
    name = "Cannabis";
    details.add(Detail("There is no marijuana on this premises"));
    details.add(Detail("There is no growth or manufacture of marijuana"));
    details.add(Detail("There is no drugs, or any illegal substances."));
  }
}

class PaintingTerm extends AdditionalTerm {
  PaintingTerm() {
    name = "Tenant Painting";
    details.add(Detail("The Landlord allows the Tenant to paint the entire unit's wall with the approved color at the Tenant's cost with \$250 reimbustment by the Landlord at the end of the lease which will be held as pet security deposit by the Landlord."));
    details.add(Detail("Tenant further agrees not to make any decorating changes to the premises without the express written consent of the Landlord or his authorized Agent."));
  }
}

class InteriorMaintenanceTerm extends AdditionalTerm {
  InteriorMaintenanceTerm() {
    name = "Interior Maintenance";
    details.add(Detail("The Tenant agrees to maintain the interior of the premises in good order and condition throughout the term"));
    details.add(Detail("The Tenant agrees to leave the premises in the same condition as received, save and except for normal wear and tear on vacant."));
  }
}

class DeductibleTerm extends AdditionalTerm {
  DeductibleTerm() {
    name = "Maintenance Deductable";
    details.add(
        Detail("The Tenant agrees to pay for and be responsible for minor repairs such as light bulbs, tap washers etc. considered as wear and tear."));
    details.add(Detail("Tenant further agrees to pay the first \$50 towards any breakage, repairs or replacement of any appliances, plumbing and electrical equipment for each occurrence."));
    details.add(Detail("This deductible applies 30 days after occupancy, this includes all light bulbs and fuse replacement."));
  }
}

class PromptNoticeTerm extends AdditionalTerm {
  PromptNoticeTerm() {
    name = "Prompt Notice of Accident";
    details.add(Detail("The Tenant shall give the Landlord prompt notice of any accident or any defect in the water pipes, heating system, air conditioning, electrical wiring and any major defect of chattels and fixtures"));
    details.add(Detail("if the costs of such repairs are to be paid by the Landlord, then any repairs with the cost shall have the Landlord's consent."));
  }
}

class DrainCleanTerm extends AdditionalTerm {
  DrainCleanTerm() {
    name = "Water Drainage";
    details.add(Detail("The Tenant agrees not to put or pour any debris, grease or any other matter in the water drainages."));
    details.add(
        Detail("The Tenant further agrees to pay the Entire Amount of bills for all sewer cleaning services resulting from the clogged pipes/sewer back up."));
  }
}

class ApplianceInGoodWorkingOrderTerm extends AdditionalTerm {
  ApplianceInGoodWorkingOrderTerm() {
    name = "Appliances";
    details.add(Detail("The Landlord represents and warrants that the appliances as listed will be in good working order at the commencement of the lease term."));
    details.add(Detail("The Tenant agrees to maintain said appliances in a state of ordinary cleanliness at the Tenant's cost."));
    details.add(Detail("The Tenant further agrees to be responsible for the full cost of repair or replacement in the event of damage or mechanical breakdown caused by the Tenant's improper use or abuse of said appliances."));
  }
}

class PropertyCleaningTerm extends AdditionalTerm {
  PropertyCleaningTerm() {
    name = "Professional Cleaning";
    details.add(
        Detail("The Landlord agrees that the property will be professionally cleaned at his own expense before the commence of the lease. "));
    details.add(
        Detail("The Tenant agrees to have it professionally cleaned at his own expense before the end of the lease. "));
    details.add(
        Detail("This includes but is not limited to; all floors, cupboards, closets, windows, doors and trims, washrooms, front yard and back yard etc."));
  }
}

class TenantAbsenceTerm extends AdditionalTerm {
  TenantAbsenceTerm() {
    name = "Tenant Absence";
    details.add(
        Detail("The Tenant shall inform the Landlord or his representative if the Tenant is away over one week and maintain the property at room temperature and shut off the main water to avoid any potential damages."));
  }
}

class TwentyFourHourNoticeTerm extends AdditionalTerm {
  TwentyFourHourNoticeTerm() {
    name = "24 Hour Notice";
    details.add(
        Detail("The landlord may visit the premises on occasional times for maintenance purposes and provide at least 24 hours notice to the Tenant. "));
  }
}

class MoveInWalkThroughTerm extends AdditionalTerm {
  MoveInWalkThroughTerm() {
    name = "Move In Walkthrough";
    details.add(Detail("The Landlord and the Tenant will do a move-in walk-through of the premises on the commencement day of the lease period to assess the condition and any pre-existing damage, and clarify the responsibilities of both parties."));
  }
}

class MoveOutWalkThroughTerm extends AdditionalTerm {
  MoveOutWalkThroughTerm() {
    name = "Move out Walkthrough";
    details.add(Detail("The Landlord and the Tenant will do a move-out walk-through of the premises at the end of the lease period to assess the condition and any damage, and clarify the responsibilities of both parties."));
  }
}

class EndOfLeaseTerm extends AdditionalTerm {
  EndOfLeaseTerm() {
    name = "End of Lease Term";
    details.add(Detail("It is further agreed and understood that the Tenant shall give at least SIXTY (60) days written notice of their intention to vacate said premises at the end of the term of the Lease. "));
    details.add(Detail("Provided further the Landlord shall have the right in addition to any other rights that he may have pursuant to the Landlord and Tenant Act."));
  }
}

class PropertyShowingTerm extends AdditionalTerm {
  PropertyShowingTerm() {
    name = "Property Showing";
    details.add(Detail("The Tenant allows the Landlord or Agents to show the property at all reasonable hours to prospective Buyers or Tenants"));
    details.add(Detail("The Tenant makes said premises to be in good conditions for all the showings, after giving the Tenant at least twenty four (24) hours notice of such showing."));
  }
}
