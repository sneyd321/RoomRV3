class Landlord {
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String deviceId = "";


  Landlord();


  void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  void setLastName(String lastName) {
    this.lastName = lastName;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  String getFullName() {
    return "$firstName $lastName";
  }

  Landlord.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    deviceId = json["deviceId"];
  }

  Map<String, dynamic> toJson(){ 
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    };
  }


}