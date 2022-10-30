
class Urgency {
  String name = "";

  Urgency();

  Urgency.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }


  Map<String, dynamic> toJson() => {
      'name': name,
  };
}

class LowUrgency extends Urgency {

  LowUrgency() {
    name = "Low";
  }


}

class MediumUrgency extends Urgency {
  MediumUrgency() {
    name = "Medium";
  }
  MediumUrgency.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }
}

class HighUrgency extends Urgency {
  HighUrgency() {
    name = "High";
  }
  HighUrgency.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }
}