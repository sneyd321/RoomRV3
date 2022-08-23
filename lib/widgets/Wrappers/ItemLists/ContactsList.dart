import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/contact.dart';
import 'package:notification_app/widgets/Cards/DetailCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';

class ContactsList extends StatefulWidget {
  final List<String> contacts;
  const ContactsList({Key? key, required this.contacts}) : super(key: key);

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
      items: widget.contacts, generator: (index) {
      String contact = widget.contacts[index];
      return DetailCard(detail: contact, onItemRemoved: (context, contact) {
        setState(() {
          widget.contacts.remove(contact);
        });
      });
    }, form: AddNameForm(names: [], onSave: (context, contact) {
      setState(() {
        widget.contacts.add(contact);
      });
    },));
  }
}