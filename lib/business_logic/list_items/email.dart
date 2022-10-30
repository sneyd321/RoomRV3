import 'package:flutter/cupertino.dart';

class EmailInfo extends ChangeNotifier {
  String email = "";

  EmailInfo(this.email);

  EmailInfo.fromJson(Map<String, dynamic> json) {
    email = json["email"];
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
    };
  }
}
