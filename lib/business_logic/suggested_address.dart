class SuggestedAddress {

    String primary = "";
    String secondary = "";
    String placesId = "";



    SuggestedAddress(this.primary, this.secondary, this.placesId);

    SuggestedAddress.fromJson(Map<String, dynamic> json) {
      
          primary = json['primary'];
          secondary = json['secondary'];
          placesId = json["placesId"];

    }
        
    
}