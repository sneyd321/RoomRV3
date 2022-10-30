import 'package:flutter/cupertino.dart';

abstract class PaymentOption extends ChangeNotifier {
  String name = "";

  PaymentOption() : super();

  PaymentOption.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }

  

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name
    };
  }

}

class CustomPaymentOption extends PaymentOption {
  CustomPaymentOption(String name) {
    this.name = name;
  }

  CustomPaymentOption.fromJson(Map<String, dynamic> json){
    name = json["name"];
  }
}

class CashPaymentOption extends PaymentOption {
  CashPaymentOption() {
    name = "Cash";
  } 
}

class ETransferPaymentOption extends PaymentOption {
  ETransferPaymentOption() {
    name = "E Transfer";
  }
}

class PostDatedChequesPaymentOption extends PaymentOption {
  PostDatedChequesPaymentOption() {
    name = "Post Dated Cheques";
  }
}