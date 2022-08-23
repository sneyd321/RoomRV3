import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/parking_description.dart';

abstract class Address extends ChangeNotifier {
  String streetNumber = "";
  String streetName = "";
  String city = "";
  String province = "";
  String postalCode = "";

  Address();

  Address.fromJson(Map<String, dynamic> json) {
    streetNumber = json["streetNumber"];
    streetName = json["streetName"];
    city = json["city"];
    province = json["province"];
    postalCode = json["postalCode"];
  }

  Map<String, dynamic> toJson();

  String getPrimaryAddress() {
    return "$streetNumber $streetName";
  }

  String getSecondaryAddress() {
    return "$city, $province $postalCode";
  }

  void setStreetNumber(String streetNumber) {
    this.streetNumber = streetNumber;
    notifyListeners();
  }

  void setStreetName(String streetName) {
    this.streetName = streetName;
  }

  void setCity(String city) {
    this.city = city;
    notifyListeners();
  }

  void setProvince(String province) {
    this.province = province;
    notifyListeners();
  }

  void setPostalCode(String postalCode) {
    this.postalCode = postalCode;
    notifyListeners();
  }
}

class LandlordAddress extends Address {
  String unitNumber = "";
  String poBox = "";

  LandlordAddress();

  LandlordAddress.fromJson(Map<String, dynamic> json) {
    streetNumber = json["streetNumber"];
    streetName = json["streetName"];
    city = json["city"];
    province = json["province"];
    postalCode = json["postalCode"];
  }


  Map<String, dynamic> toJson() {
    return {
      "streetNumber": streetNumber,
      "streetName": streetName,
      "city": city,
      "province": province,
      "postalCode": postalCode,
      "unitNumber": unitNumber,
      "poBox": poBox
    };
  }

  void setUnitNumber(String unitNumber) {
    this.unitNumber = unitNumber;
    notifyListeners();
  }

  void setPOBox(String poBox) {
    this.poBox = poBox;
    notifyListeners();
  }
}

class RentalAddress extends Address {
  String unitName = "";
  bool isCondo = false;
  List<ParkingDescription> parkingDescriptions = [];

  RentalAddress();

  RentalAddress.fromJson(Map<String, dynamic> json) {
    streetNumber = json["streetNumber"];
    streetName = json["streetName"];
    city = json["city"];
    province = json["province"];
    postalCode = json["postalCode"];
  }

  Map<String, dynamic> toJson() => {
        "streetNumber": streetNumber,
        "streetName": streetName,
        "city": city,
        "province": province,
        "postalCode": postalCode,
        "unitName": unitName,
        "isCondo": isCondo,
        "parkingDescriptions": parkingDescriptions.map((ParkingDescription parkingDescription) => parkingDescription.toJson()).toList()
      };

  void setUnitName(String unitName) {
    this.unitName = unitName;
    notifyListeners();
  }

  void setIsCondo(bool isCondo) {
    this.isCondo = isCondo;
    notifyListeners();
  }

  void addParkingDescription(String parkingDescription) {
    parkingDescriptions.add(ParkingDescription(parkingDescription));
    notifyListeners();
  }
}
