
class Contact {
  String contact = "";

  Contact(this.contact);

  Contact.fromJson(Map<String, dynamic> json) {
    contact = json["contact"];
  }

  void setContact(String contact) {
    this.contact = contact;
  }

  Map<String, dynamic> toJson() {
    return {
      "contact": contact,
    };
  }
}
