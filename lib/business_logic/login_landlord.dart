class LoginLandlord {

  String email = "";
  String password = "";
  String deviceId = "";

  LoginLandlord();

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setDeviceId(String deviceId) {
    this.deviceId = deviceId;
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "deviceId": deviceId
    };
  }

}