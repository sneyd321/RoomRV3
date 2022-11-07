
class ParkingDescription {
  String description = "";

  ParkingDescription(this.description);

  ParkingDescription.fromJson(Map<String, dynamic> json) {
    description = json["description"];
  }

  void setDescription(String description) {
    this.description = description;
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
    };
  }
}
