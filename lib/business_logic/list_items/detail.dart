
class Detail  {
  String detail = "";

  Detail(this.detail);

  
  Detail.fromJson(Map<String, dynamic> json) {
    detail = json["detail"];
  }

  void setDetail(String detail) {
    this.detail = detail;
  }

  Map<String, dynamic> toJson() {
    return {
      "detail": detail,
    };
  }
}
