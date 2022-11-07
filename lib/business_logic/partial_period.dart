


class PartialPeriod   {
  String amount = '';
  String dueDate = '';
  String startDate = '';
  String endDate = '';
  bool isEnabled = false;

  PartialPeriod();

  PartialPeriod.fromJson(Map<String, dynamic> json)
      : amount = json["amount"],
        dueDate = json["dueDate"],
        startDate = json["startDate"],
        endDate = json["endDate"],
        isEnabled = json["isEnabled"];

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "dueDate": dueDate,
        "startDate": startDate,
        "endDate": endDate,
        "isEnabled": isEnabled
      };

  void setEnabled(bool value) {
    isEnabled = value;
  }

  void setAmount(String amount) {
    this.amount = amount;
  }

  void setDueDate(String dueDate) {
    this.dueDate = dueDate;
  }

  void setStartDate(String startDate) {
    this.startDate = startDate;
  }

  void setEndDate(String endDate) {
    this.endDate = endDate;
  }

  
}
