import 'package:flutter/cupertino.dart';


class TenantName extends ChangeNotifier {
  String name = "";

  TenantName(this.name);

  TenantName.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    return {
       "name": name
    };
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

}