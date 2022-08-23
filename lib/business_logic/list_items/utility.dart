

import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/detail.dart';

abstract class Utility extends ChangeNotifier {
  
  String name = "";
  String responsibility = "Tenant";
  List<Detail> details = [];

  Utility() {
    details.add(Detail("Tenant sets up account with $name provider and pays the utiltiy provider"));
    details.add(Detail("Tenant pays a portion of the $name costs"));
    details.add(Detail("Tenant agrees to pay the cost of $name required in the premises and the extention thereof"));
    details.add(Detail("Tenant further agrees to provide proof to the Landlord on or before the date of possession that the service has been transferred to the Tenant's name."));
  }


  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "responsibility": responsibility,
      "details": details.map((Detail detail) => detail.toJson()).toList()
    };
    
  }

  void addDetail(String detail) {
    details.add(Detail(detail));
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setResponsibility(String responsibility) {
    this.responsibility = responsibility;
    notifyListeners();
  }
}

class ElectricityUtility extends Utility {
  ElectricityUtility() : super() {
    name = "Electricity";
  }
}

class HeatUtility extends Utility {
  HeatUtility() : super() {
    name = "Heat";
   
  }
}

class WaterUtility extends Utility {
  WaterUtility() : super() {
    name = "Water";
  }
}

               
class InternetUtility extends Utility {
  InternetUtility() : super() {
    name = "Internet";
    responsibility = "Tenant";
  }
}

class CustomUtility extends Utility {
  CustomUtility(String name) : super() {
    this.name = name;
  }

}
