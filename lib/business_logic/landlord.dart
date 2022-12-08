import 'package:notification_app/business_logic/address.dart';

class Landlord {
  int id = 0;
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String profileURL = "";
  String phoneNumber = "";
  String state = "";
  String deviceId = "";
  LandlordAddress landlordAddress = LandlordAddress();


  Landlord();


  void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  void setLastName(String lastName) {
    this.lastName = lastName;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  String getFullName() {
    return "$firstName $lastName";
  }

  void setLandlordAddress(LandlordAddress landlordAddress) {
    this.landlordAddress = landlordAddress;
  }

  Landlord.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    phoneNumber = json["phoneNumber"];
    state = json["state"];
    profileURL = json["profileURL"];
    deviceId = json["deviceId"];
    id = json["id"];
    landlordAddress = LandlordAddress.fromJson(json["landlordAddress"]);
  }

  Map<String, dynamic> toCreateLandlordJson(){ 
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "landlordAddress": landlordAddress.toJson()
    };
  }

  Map<String, dynamic> toLandlordJson(){ 
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "state": state,
      "password": password,
      "profileURL": profileURL,
      "deviceId": deviceId,
      "landlordAddress": landlordAddress.toJson()
    };
  }


}