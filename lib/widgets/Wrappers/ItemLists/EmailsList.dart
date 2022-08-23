import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/email.dart';
import 'package:notification_app/widgets/Cards/DetailCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddEmailForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';

class EmailsList extends StatefulWidget {
  final List<String> emails;
  const EmailsList({Key? key, required this.emails}) : super(key: key);

  @override
  State<EmailsList> createState() => _EmailsListState();
}

class _EmailsListState extends State<EmailsList> {
  @override
  Widget build(BuildContext context) {
    return SliverAddItemGeneratorWrapper(
      shirnkWrap: true,
      addButtonTitle: "Add Email",
      noItemsText: "No Emails",
      items: widget.emails, generator: (index) {
      String email = widget.emails[index];
      return DetailCard(detail: email, onItemRemoved: (context, email) {
        setState(() {
          widget.emails.remove(email);
        });
      });
    }, form: AddEmailForm(names: [], onSave: (context, email) {
      setState(() {
        widget.emails.add(email);
      });
    },));
  }
}