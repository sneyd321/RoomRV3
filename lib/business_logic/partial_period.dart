

import 'package:flutter/cupertino.dart';

class PartialPeriod extends ChangeNotifier {
  String amount = '';
  String dueDate = '';
  String startDate = '';
  String endDate = '';
  bool isEnabled = false;

  PartialPeriod();

  PartialPeriod.fromJson(Map<String, dynamic> json)
      : amount = json["amount"],
        dueDate = json["dueDate"],
        startDate = json["startDate"],
        endDate = json["endDate"],
        isEnabled = json["isEnabled"];

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "dueDate": dueDate,
        "startDate": startDate,
        "endDate": endDate,
        "isEnabled": isEnabled
      };

  void setEnabled(bool value) {
    isEnabled = value;
    notifyListeners();
  }

  void setAmount(String amount) {
    this.amount = amount;
    notifyListeners();
  }

  void setDueDate(String dueDate) {
    this.dueDate = dueDate;
    notifyListeners();
  }

  void setStartDate(String startDate) {
    this.startDate = startDate;
    notifyListeners();
  }

  void setEndDate(String endDate) {
    this.endDate = endDate;
    notifyListeners();
  }

  
}
