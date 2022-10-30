class MaintenanceTicketNotification {
  String dateCreated = "";
  String houseKey = "";
  MaintenanceTicketNotificationData data = MaintenanceTicketNotificationData();

  MaintenanceTicketNotification.fromJson(Map<String, dynamic> json) {
    houseKey = json["houseKey"];
    data = MaintenanceTicketNotificationData.fromJson(json["data"]);
  }

  String getFullName() {
    return "${data.firstName} ${data.lastName}";
  }

  



}

class MaintenanceTicketNotificationData {
  String description = "";
  String firstName = "";
  String lastName = "";
  String imageURL = "";
  int maintenanceTicketId = 0;

  MaintenanceTicketNotificationData();

  MaintenanceTicketNotificationData.fromJson(Map<String, dynamic> json) {
    description = json["description"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    imageURL = json["imageURL"];
    maintenanceTicketId = json["maintenanceTicketId"];
  }



}