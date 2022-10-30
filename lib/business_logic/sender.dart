
import 'package:notification_app/business_logic/landlord.dart';

class Sender {
  String firstName = "";
  String lastName = "";
  String email = "";


  Sender();

  Sender.fromLandlord(Landlord landlord) {
    firstName = landlord.firstName;
    lastName = landlord.lastName;
    email = landlord.email;
  }

  Sender.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email
    };

  }


  void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  void setLastName(String lastName) {
    this.lastName = lastName;
  }

  void setEmail(String email) {
    this.email = email;
  }


}