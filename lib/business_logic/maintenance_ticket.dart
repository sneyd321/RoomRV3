

import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/sender.dart';

import '_picture.dart';
import 'timestamp.dart';
import 'description.dart';
import 'urgency.dart';

class MaintenanceTicket extends ChangeNotifier {
  String name = "MaintenanceTicket";
  Picture picture = Picture.fromFile("");
  Description description = Description("");
  Urgency urgency = LowUrgency();
  Sender sender = Sender();
  Timestamp timestamp = Timestamp();
  String firebaseId = "";
  String datePosted = "";

  MaintenanceTicket() {
    datePosted = timestamp.getCurrentTimestamp();
  }

  void setSender(Sender sender) {
    this.sender = sender;
  }

  void setFilePath(String filePath) {
    picture = Picture.fromFile(filePath);
    notifyListeners();
  }

  void setURL(String url) {
    picture = Picture.fromUrl(url);
    notifyListeners();
  }

  void setDescription(Description description) {
    this.description = description;
    notifyListeners();
  }

  void setUrgency(String urgency) {
    switch (urgency) {
      case "Low":
        this.urgency = LowUrgency();
        break;
      case "Medium":
        this.urgency = MediumUrgency();
        break;
      case "High":
        this.urgency = HighUrgency();
        break;    
    }
    notifyListeners();
  }

  void setFirebaseId(String firebaseId) {
    this.firebaseId = firebaseId;
    notifyListeners();
  }




  MaintenanceTicket.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    picture = Picture.fromUrl(json["imageURL"]);
    datePosted = json["datePosted"];
    firebaseId = json["firebaseId"];
    description = Description.fromJson(json["description"]);
    urgency = Urgency.fromJson(json["urgency"]);
    sender = Sender.fromJson(json["sender"]);
  }


  Map<String, dynamic> toJson() => {
      'description': description.toJson(),
      'urgency': urgency.toJson(),
      "sender": sender.toJson()

  };

  

}

