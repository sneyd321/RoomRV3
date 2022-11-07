

import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/business_logic/timestamp.dart';

class Comment  {

  String comment = "";
  String name = "";
  String email = "";
  String firstName = "";
  String lastName = "";
  final Timestamp timestamp = Timestamp();

  String getFullName() {
    return "$firstName $lastName";
  }

  String getCurrentTime() {
    return timestamp.getCurrentTimestamp();
  }

  Comment();

  Comment.fromLandlord(Landlord landlord) {
    firstName = landlord.firstName;
    lastName = landlord.lastName;
    email = landlord.email;
  }

  void setComment(String comment) {
    this.comment = comment;
  }

  void setName(String name) {
    this.name = name;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  void setLastName(String lastName) {
    this.lastName = lastName;
  }
  
  


  String? validate() {
     if (comment.length > 140) {
      return "Please enter a comment shorter than 140 characters";
    }
    if (comment.isEmpty) {
      return "Please enter a comment.";
    }
    return null;
  }

  Comment.fromJson(Map<String, dynamic> json) {
    
    comment = json["comment"];
    name = json["name"];
    email = json["email"];
    firstName = json["firstName"];
    lastName = json["lastName"];
  }

  Map<String, dynamic> toJson() => {
      'name': name,
      'comment': comment,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      "timestamp": timestamp.getCurrentDateTime()
  };
}

class TextComment extends Comment {


  TextComment() : super() {
    name = "text";
  }

  TextComment.fromLandlord(Landlord landlord) {
    firstName = landlord.firstName;
    lastName = landlord.lastName;
    email = landlord.email;
    name = "text";
  }



  TextComment.fromJson(Map<String, dynamic> json) : super.fromJson(json);

}


class ImageComment extends Comment {
  ImageComment() : super() {
    name = "image";
  }

  ImageComment.fromLandlord(Landlord landlord) {
    firstName = landlord.firstName;
    lastName = landlord.lastName;
    email = landlord.email;
    name = "image";
  }

  ImageComment.fromJson(Map<String, dynamic> json) : super.fromJson(json);

}