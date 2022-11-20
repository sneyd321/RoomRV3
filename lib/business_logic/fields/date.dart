import 'package:intl/intl.dart';

abstract class Date {
  String date = "";

  Date(this.date);
   
  Date.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();


  DateTime parseDate(String date) {
    if (date.isEmpty) {
      return DateFormat('yyyy/MM/dd').parse("1970/01/01");
    }
    try {
      return DateFormat('yyyy/MM/dd').parse(date);
    } on FormatException {
      return DateFormat('yyyy/MM/dd').parse("1970/01/01");
    }
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }

  String getDate() {
    return date;
  }

  String? validate();
}

class StartDate extends Date {
  StartDate(date) : super(date);
  StartDate.fromJson(Map<String, dynamic> json) : super.fromJson(json) {

    date = formatDate(parseDate(json["startDate"]));
  }

  @override
  String? validate() {
    if (date.isEmpty) {
      return "Please enter a start date.";
    }
    if (date == "1970/01/01") {
      return "Please enter a start date.";
    }
    return null;
  }

  @override
  Map<String, dynamic> toJson() {
    return {"startDate": date};
  }
}

class DueDate extends Date {
  DueDate(date) : super(date);

  DueDate.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    date = formatDate(parseDate(json["dueDate"]));
  }

  @override
  String? validate() {
    if (date.isEmpty) {
      return "Please enter a date partial rent will be due.";
    }
    if (date == "1970/01/01") {
      return "Please enter a date partial rent will be due.";
    }
    return null;
  }

  @override
  Map<String, dynamic> toJson() {
    return {"dueDate": date};
  }
}

class EndDate extends Date {
  EndDate(date) : super(date);

  EndDate.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    date = formatDate(parseDate(json["endDate"]));
  }

  @override
  String? validate() {
    if (date.isEmpty) {
      return "Please enter an end date.";
    }
    if (date == "1970/01/01") {
      return "Please enter an end date.";
    }
    

    return null;
  }

  String? validateDateRange(String startDate) {
    if (parseDate(date).isAfter(parseDate(startDate))) {

      return "Please enter a date after $startDate.";
    }
    return null;

  }



  @override
  Map<String, dynamic> toJson() {
    return {"endDate": date};
  }
}
