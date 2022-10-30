import 'package:notification_app/business_logic/list_items/tenant_name.dart';

class Tenant {
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String tenantState = "Not Approved";


  Tenant();

  Tenant.fromTenantName(TenantName tenantName) {
    List<String> names = tenantName.name.split(" ");
    firstName = names[0];
    if (names.length > 1) {
      for (int i = 1; i < names.length; i++) {
        lastName += names[i];
      }
      
    }
  } 

  String getFullName() {
    return "$firstName $lastName";
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "tenantState": tenantState,
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

  void setPassword(String value) {
    password = value;
  } 

  void setState(String state) {
    tenantState = state;
  }



}