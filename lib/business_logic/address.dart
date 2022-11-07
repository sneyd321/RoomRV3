import 'package:notification_app/business_logic/list_items/parking_description.dart';

abstract class Address  {
  String streetNumber = "";
  String streetName = "";
  String city = "";
  String province = "";
  String postalCode = "";

  Address();

  Map<String, dynamic> toJson();

  String getPrimaryAddress() {
    return "$streetNumber $streetName";
  }

  String getSecondaryAddress() {
    return "$city, $province $postalCode";
  }

  void setStreetNumber(String streetNumber) {
    this.streetNumber = streetNumber;
  }

  void setStreetName(String streetName) {
    this.streetName = streetName;
  }

  void setCity(String city) {
    this.city = city;
  }

  void setProvince(String province) {
    this.province = province;
  }

  void setPostalCode(String postalCode) {
    this.postalCode = postalCode;
  }
}

class PredictedAddress extends Address {
  PredictedAddress.fromJson(Map<String, dynamic> json) {
    streetNumber = json["streetNumber"];
    streetName = json["streetName"];
    city = json["city"];
    province = json["province"];
    postalCode = json["postalCode"];
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "streetNumber": streetNumber,
      "streetName": streetName,
      "city": city,
      "province": province,
      "postalCode": postalCode
    };
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
    unitNumber = json["unitNumber"];
    poBox = json["poBox"];
  }

  @override
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
  }

  void setPOBox(String poBox) {
    this.poBox = poBox;
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
    isCondo = json["isCondo"];
    unitName = json["unitName"];
    parkingDescriptions = json["parkingDescriptions"].map<ParkingDescription>((json) => ParkingDescription.fromJson(json)).toList();
  }

  @override
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
  }

  void setIsCondo(bool isCondo) {
    this.isCondo = isCondo;
  }

  void addParkingDescription(String parkingDescription) {
    parkingDescriptions.add(ParkingDescription(parkingDescription));
  }
}
