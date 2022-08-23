import 'package:intl/intl.dart';

abstract class NumberField {
  String amount = "";
  NumberField(this.amount);
  NumberFormat oCcy = NumberFormat("#,##0.00", "en_US");

  NumberField.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  String formatNumber(String amount) {
    if (amount.isEmpty) {
      return "0.00";
    }
    try {
      num parsedNumber = oCcy.parse(amount);
      return oCcy.format(parsedNumber); 
    }
    on FormatException {
      return "0.00";
    }
    
  }

  String getFormattedNumber() {
    return formatNumber(amount);
  }

  String getAmount(){
    return amount;
  }
  
  String? validate();

}


class Amount extends NumberField {
  Amount(String amount) : super(amount);

  Amount.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    amount = json["amount"];
  }


  @override
  String? validate() {
    if (amount.isEmpty) {
      return "Please enter an amount.";
    }
    return null;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "amount": formatNumber(amount)
    };
  }

}

class BaseRent extends NumberField {
  BaseRent(amount) : super(amount);

  BaseRent.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    amount = json["baseRent"];
  }

   @override
  Map<String, dynamic> toJson() {
    return {
      "baseRent": formatNumber(amount)
    };
  }

  @override
  String? validate() {
    if (amount.isEmpty) {
      return "Please enter the base rent.";
    }
    return null;
  }

 

}