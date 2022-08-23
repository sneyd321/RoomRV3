import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/contact.dart';
import 'package:notification_app/business_logic/list_items/email.dart';

class LandlordInfo extends ChangeNotifier {
  String fullName = "";
  bool receiveDocumentsByEmail = true;
  List<EmailInfo> emails = [];
  bool contactInfo = true;
  List<Contact> contacts = [];

  LandlordInfo();


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
    notifyListeners();
  }

  void setReceiveDocumentsByEmail(bool receiveDocumentsByEmail) {
    this.receiveDocumentsByEmail = receiveDocumentsByEmail;
    notifyListeners();
  }

  void addEmail(String email) {
    emails.add(EmailInfo(email));
    notifyListeners();
  }

  void setContactInfo(bool contactInfo) {
    this.contactInfo = contactInfo;
    notifyListeners();
  }

  void addContactInfo(String contactInfo) {
    contacts.add(Contact(contactInfo));
    notifyListeners();
  }




}