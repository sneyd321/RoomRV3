import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/lease.dart';

class House extends ChangeNotifier {

  int houseId = 0;
  String houseKey = "";
  String firebaseId = "";
  Lease lease = Lease();


  House();

  House.fromJson(Map<String, dynamic> json) {
    houseId = json["id"];
    houseKey = json["houseKey"];
    firebaseId = json["firebaseId"];
    lease = Lease.fromJson(json["lease"]);

  }

  void setFirebaseId(String firebaseId) {
    this.firebaseId = firebaseId;
    notifyListeners();
  }

  void setLease(Lease lease) {
    this.lease = lease;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      "firebaseId": firebaseId,
      "lease": lease.toJson()
    };
  }


}