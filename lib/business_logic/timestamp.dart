


class Timestamp {

  String getCurrentTimestamp() {
    DateTime _now = DateTime.now();
    return '${_now.year}-${_now.month}-${_now.day}';
  }

  DateTime getCurrentDateTime() {
    return DateTime.now();
  }

  String parseDateCreated(String dateCreated) {
    
    DateTime _now = DateTime.parse(dateCreated);
    String month = _now.month < 10 ? "0${_now.month}" : "${_now.month}";
    String day = _now.day < 10 ? "0${_now.day}" : "${_now.day}";
    return '${_now.year}-$month-$day';
  }

}