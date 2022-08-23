import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/partial_period.dart';

import 'package:notification_app/business_logic/rental_period.dart';

class TenancyTerms extends ChangeNotifier {
  RentalPeriod rentalPeriod = RentalPeriod("Fixed Term");
  String startDate = '';
  String rentDueDate = "First";
  String paymentPeriod = "Month";
  PartialPeriod partialPeriod = PartialPeriod();

  TenancyTerms();

  TenancyTerms.fromJson(Map<String, dynamic> json) {
    rentalPeriod = RentalPeriod.fromJson(json["rentalPeriod"]);
    startDate = json["startDate"];
    rentDueDate = json["rentDueDate"];
    paymentPeriod = json["paymentPeriod"];
    partialPeriod = PartialPeriod.fromJson(json["partialPeriod"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "rentalPeriod": rentalPeriod.toJson(),
      "startDate": startDate,
      "rentDueDate": rentDueDate,
      "paymentPeriod": paymentPeriod,
      "partialPeriod": partialPeriod.toJson()
    };
  }


  String getDateRange() {
    if (rentalPeriod.endDate.isNotEmpty) {
      return "$startDate - ${rentalPeriod.endDate}";
    }
    return "$startDate - ${rentalPeriod.rentalPeriod}";
  }

  void setStartDate(String startDate) {
    this.startDate = startDate;
    notifyListeners();
  }

  void setRentalPeriod(RentalPeriod rentalPeriod) {
    this.rentalPeriod = rentalPeriod;
    notifyListeners();
  }

  void setPartialPeriod(PartialPeriod partialPeriod) {
    this.partialPeriod = partialPeriod;
  }

  void setRentDueDate(String rentDueDate) {
    this.rentDueDate = rentDueDate;
    notifyListeners();
  }

  void setPaymentPeriod(String paymentPeriod) {
    this.paymentPeriod = paymentPeriod;
    notifyListeners();
  }
}
