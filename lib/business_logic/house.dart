import 'package:notification_app/business_logic/lease.dart';

class House   {

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
  }

  void setLease(Lease lease) {
    this.lease = lease;
  }

  Map<String, dynamic> toJson() {
    return {
      "firebaseId": firebaseId,
      "lease": lease.toJson()
    };
  }


}