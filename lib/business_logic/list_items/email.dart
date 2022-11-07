
class EmailInfo {
  String email = "";

  EmailInfo(this.email);

  EmailInfo.fromJson(Map<String, dynamic> json) {
    email = json["email"];
  }

  void setEmail(String email) {
    this.email = email;
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
    };
  }
}
