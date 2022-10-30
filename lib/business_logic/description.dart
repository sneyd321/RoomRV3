class Description {

  String description = "";



  Description(this.description);

  Description.fromJson(Map<String, dynamic> json) {

    description = json["descriptionText"];
  }

  String? validate() {
    if (description.length > 140) {
      return "Please enter a description shorter than 140 characters";
    }
    if (description.length < 14) {
      return "Please enter a description longer than 14 characters";
    }
    return null;
  }



  Map<String, dynamic> toJson() => {
      'descriptionText': description,
  };
  
}