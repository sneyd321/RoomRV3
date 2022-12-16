
class Tenant {
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String password = "";
  String profileURL = "";
  String state = "";
  int houseId = 0;


  Tenant();

  Tenant.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    state = json["state"];
    profileURL = json["profileURL"];
    phoneNumber = json["phoneNumber"];
    
    houseId = json["houseId"];
  }

  
  String getFullName() {
    return "$firstName $lastName";
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    };
  }



  void setFirstName(String value) {
    firstName = value;
  }

  void setLastName(String value) {
    lastName = value;
  }

  void setEmail(String value) {
    email = value;
  }

  void setState(String state) {
    this.state = state;
  }

}