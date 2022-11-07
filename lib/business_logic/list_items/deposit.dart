import 'package:intl/intl.dart';
import 'package:notification_app/business_logic/list_items/detail.dart';

abstract class Deposit {
  String name = "";
  String amount = "";
  List<Detail> details = [];
  NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");


  Deposit();

  Deposit.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    amount = json["amount"];
    details = json["details"].map<Detail>((json) => Detail.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
      return {
        "name": name,
        "amount": amount,
        "details": details.map((Detail detail) => detail.toJson()).toList()
      };
    }


  void setName(String name) {
    this.name = name;
  }

  void setAmount(String amount) {
    this.amount = amount;
  }

  void addDetail(String detail) {
    details.add(Detail(detail));
  }

  String getAmount() {
    if (this.amount.isEmpty) {
      return "0.00";
    }
    num amount = currencyFormat.parse(this.amount);
    return currencyFormat.format(amount);
  }

  

  

}


class RentDeposit extends Deposit {

  RentDeposit(String baseRent) {
    name = "Rent Deposit";
    amount = baseRent;
  }



}

class KeyDeposit extends Deposit {

  KeyDeposit() {
    name = "Key Deposit";
    amount = "300.00";
    details.add(Detail("The Tenant agrees and understands that loss of any keys and/or passes to the said premises during the term of the Lease are to be replaced at his own expense."));
    details.add(Detail("The Tenant agrees to submit a \$$amount refundable deposit to the Landlord for keys and remote(s)."));
  }
}

class PetDamageDeposit extends Deposit {
  PetDamageDeposit() {
    name = "Pet Damage Deposit";
    amount = "250.00";
    details.add(Detail("Tenant agrees to be responsible for any repair or replacement cost due to the presence of any pets on the premises."));
    details.add(Detail("Tenant shall, at lease termination, make any repairs that may be necessary to restore any damages caused by pets."));
    details.add(Detail("Tenant shall reimburse the Landlord for the cost of any repairs resulting from the damage."));
    details.add(Detail("The Tenant agrees to clean up after the pet so that there is no pet hair, urine, or feces remaining or visible anywhere in or on the Leased Premises and the building or common areas where the Leased Premises forms a part"));
    details.add(Detail("The Tenant shall keep the pet on a leash while the pet is in the common area of the building in which the Leased Premises forms a part. "));
    details.add(Detail("The Landlord shall keep \$$amount security deposit from the reimbustment fund to the Tenant for the some of the cost of painting by the tenant."));
  }
}

class MaintenanceDeductableDeposit extends Deposit {

  MaintenanceDeductableDeposit() {
    name = "Maintenance Ticket Deductable";
    amount = "50.00";
    details.add(Detail("The Tenant agrees to pay for and be responsible for minor repairs such as light bulbs, tap washers etc. considered as wear and tear."));
    details.add(Detail("Tenant further agrees to pay the first \$$amount towards any breakage, repairs or replacement of any appliances, plumbing and electrical equipment for each occurrence."));
    details.add(Detail("This deductible applies 30 days after occupancy, this includes all light bulbs and fuse replacement."));
            
  }

}

class CustomDeposit extends Deposit {
  CustomDeposit(String name, String amount) {
    this.name = name;
    this.amount = amount;
  }
    CustomDeposit.fromJson(Map<String, dynamic> json): super() {
       name = json["name"];
      amount = json["amount"];
      details = json["details"].map<Detail>((json) => Detail.fromJson(json)).toList();
    }


}