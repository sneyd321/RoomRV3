import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/detail.dart';

abstract class RentDiscount extends ChangeNotifier {
  String name = "";
  String amount = "0.00";
  List<Detail> details = [];

  RentDiscount();

  RentDiscount.fromJson(Map<String, dynamic> json) {
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

  


  void setAmount(String amount) {
    this.amount = amount;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void addDetail(String detail) {
    details.add(Detail(detail));
    notifyListeners();
  }
}

class CustomRentDiscount extends RentDiscount {


  CustomRentDiscount(String name, String amount) : super() {
    this.name = name;
    this.amount = amount;
  }

  CustomRentDiscount.fromJson(Map<String, dynamic> json): super() {
     name = json["name"];
    amount = json["amount"];
    details = json["details"].map<Detail>((json) => Detail.fromJson(json)).toList();
  }


}
