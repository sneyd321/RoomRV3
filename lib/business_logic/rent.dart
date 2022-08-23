import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/business_logic/list_items/payment_option.dart';

import 'list_items/rent_services.dart';


class Rent extends ChangeNotifier {
  String baseRent = "";
  String rentMadePayableTo = "";
  List<RentService> rentServices = [];
  List<PaymentOption> paymentOptions = [ETransferPaymentOption(), PostDatedChequesPaymentOption(), CashPaymentOption()];
  NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");
  Rent();

  Rent.fromJson(Map<String, dynamic> json) {
    baseRent = json["baseRent"];
    rentMadePayableTo = json["rentMadePayableTo"];
    rentServices = json["rentServices"].map<RentService>((rentServiceJson) => CustomRentService.fromJson(rentServiceJson)).toList();
    paymentOptions = json["paymentOptions"].map<PaymentOption>((paymentOptionJson) => CustomPaymentOption.fromJson(paymentOptionJson)).toList();
  }
  
   Map<String, dynamic> toJson() => {
     "baseRent": baseRent,
     "rentMadePayableTo": rentMadePayableTo,
     "rentServices": rentServices.map((rentService) => rentService.toJson()).toList(),
     "paymentOptions": paymentOptions.map((paymentOption) => paymentOption.toJson()).toList()
   };

  void setBaseRent(String baseRent) {
    this.baseRent = baseRent;
    notifyListeners();
  }

  void setRentMadePayableTo(String rentMadePayableTo) {
    this.rentMadePayableTo = rentMadePayableTo;
    notifyListeners();
  }

   String getTotalLawfulRent() {
    
    num rent = baseRent.isNotEmpty ? currencyFormat.parse(baseRent) : 0.0;
    for (RentService rentService in rentServices) { 
      rent += currencyFormat.parse(rentService.amount); 
    }
    return currencyFormat.format(rent); 
  }

  void addRentService(RentService rentService) {
    rentServices.add(rentService);
    notifyListeners();
  }

  void removeRentService(RentService rentService) {
    rentServices.remove(rentService);
    notifyListeners();
  }

 

}

