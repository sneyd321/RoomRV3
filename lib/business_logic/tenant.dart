
class Tenant {
  String firstName = "";
  String lastName = "";
  String email = "";
  String tenantState = "Not Approved";
  int tenantPosition = 0;
  int houseId = 0;


  Tenant();

  Tenant.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    tenantState = json["tenantState"];
    tenantPosition = json["tenantPosition"];
    houseId = json["houseId"];
  }

  
  String getFullName() {
    return "$firstName $lastName";
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email
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
    tenantState = state;
  }

}