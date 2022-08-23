import 'package:flutter/cupertino.dart';

class Detail extends ChangeNotifier {
  String detail = "";

  Detail(this.detail);

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
