import 'package:flutter/cupertino.dart';

class ParkingDescription extends ChangeNotifier {
  String description = "";

  ParkingDescription(this.description);

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
