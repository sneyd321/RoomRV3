import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/contact.dart';
import 'package:notification_app/widgets/Cards/DetailCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';

import '../../../business_logic/landlord_info.dart';

class ContactsList extends StatefulWidget {
  final LandlordInfo landlordInfo;
  const ContactsList({Key? key, required this.landlordInfo}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return SliverAddItemGeneratorWrapper(
        shirnkWrap: true,
        addButtonTitle: "Add Contact",
        noItemsText: "No Contacts",
        items: widget.landlordInfo.contacts,
        generator: (index) {
          String contact = widget.landlordInfo.contacts[index].contact;
          return DetailCard(
              detail: contact,
              onItemRemoved: (context, contact) {
                setState(() {
                  Contact contactToDelete = widget.landlordInfo.contacts
                      .where((element) => element.contact == contact)
                      .first;
                  widget.landlordInfo.contacts.remove(contactToDelete);
                });
              });
        },
        form: AddNameForm(
          names: [],
          onSave: (context, contact) {
            setState(() {
              if (widget.landlordInfo.contacts.where((element) => element.contact == contact).isNotEmpty) {
                return;
              }
              Contact contactToAdd = Contact(contact);
              widget.landlordInfo.contacts.add(contactToAdd);
            });
          },
        ));
  }
}
