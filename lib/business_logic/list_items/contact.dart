import 'package:flutter/cupertino.dart';

class Contact extends ChangeNotifier {
  String contact = "";

  Contact(this.contact);

  Contact.fromJson(Map<String, dynamic> json) {
    print(json);
    contact = json["contact"];
  }

  void setContact(String contact) {
    this.contact = contact;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      "contact": contact,
    };
  }
}
