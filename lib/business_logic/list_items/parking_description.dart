import 'package:flutter/cupertino.dart';

class ParkingDescription extends ChangeNotifier {
  String description = "";

  ParkingDescription(this.description);

  ParkingDescription.fromJson(Map<String, dynamic> json) {
    description = json["description"];
  }

  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
    };
  }
}
