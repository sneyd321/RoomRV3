
class RentalPeriod   {
  String rentalPeriod = "";
  String endDate = '';

  RentalPeriod(this.rentalPeriod);
  RentalPeriod.fromJson(Map<String, dynamic> json)
      : rentalPeriod = json["rentalPeriod"],
        endDate = json["endDate"];

  Map<String, dynamic> toJson() {
    return {"rentalPeriod": rentalPeriod, "endDate": endDate};
  }

  void setRentalPeriod(String rentalPeriod) {
    this.rentalPeriod = rentalPeriod;
    
  }

  void setEndDate(String endDate) {
    this.endDate = endDate;
  }

}
