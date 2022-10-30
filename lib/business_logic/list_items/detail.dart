import 'package:flutter/cupertino.dart';

class Detail extends ChangeNotifier {
  String detail = "";

  Detail(this.detail);

  
  Detail.fromJson(Map<String, dynamic> json) {
    detail = json["detail"];
  }

  void setDetail(String detail) {
    this.detail = detail;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      "detail": detail,
    };
  }
}
