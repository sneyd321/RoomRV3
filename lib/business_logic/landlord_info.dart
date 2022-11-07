import 'package:notification_app/business_logic/list_items/contact.dart';
import 'package:notification_app/business_logic/list_items/email.dart';

class LandlordInfo   {
  String fullName = "";
  bool receiveDocumentsByEmail = true;
  List<EmailInfo> emails = [];
  bool contactInfo = true;
  List<Contact> contacts = [];

  LandlordInfo();

  LandlordInfo.fromJson(Map<String, dynamic> json) {
    fullName = json["fullName"];
    receiveDocumentsByEmail = json["receiveDocumentsByEmail"];
    emails = json["emails"].map<EmailInfo>((json)=> EmailInfo.fromJson(json)).toList();
    contactInfo = json["contactInfo"];
    contacts = json["contacts"].map<Contact>((json) => Contact.fromJson(json)).toList();
  }


  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "receiveDocumentsByEmail": receiveDocumentsByEmail,
      "emails": emails.map((EmailInfo email) => email.toJson()).toList(),
      "contactInfo": contactInfo,
      "contacts": contacts.map((Contact contact) => contact.toJson()).toList()
    };
    
  }

  void setFullName(String fullName) {
    this.fullName = fullName;
  }

  void setReceiveDocumentsByEmail(bool receiveDocumentsByEmail) {
    this.receiveDocumentsByEmail = receiveDocumentsByEmail;
  }

  void addEmail(String email) {
    emails.add(EmailInfo(email));
  }

  void setContactInfo(bool contactInfo) {
    this.contactInfo = contactInfo;
  }

  void addContactInfo(String contactInfo) {
    contacts.add(Contact(contactInfo));
  }




}