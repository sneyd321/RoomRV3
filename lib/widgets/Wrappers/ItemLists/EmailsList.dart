import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/landlord_info.dart';
import 'package:notification_app/business_logic/list_items/email.dart';
import 'package:notification_app/widgets/Cards/DetailCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddEmailForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';

class EmailsList extends StatefulWidget {
  final LandlordInfo landlordInfo;
  const EmailsList({Key? key, required this.landlordInfo}) : super(key: key);

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
        items: widget.landlordInfo.emails,
        generator: (index) {
          String email = widget.landlordInfo.emails[index].email;
          return DetailCard(
              detail: email,
              onItemRemoved: (context, email) {
                setState(() {
                  EmailInfo emailInfo = widget.landlordInfo.emails.where((element) => element.email == email).first;
                  widget.landlordInfo.emails.remove(emailInfo);
                });
              });
        },
        form: AddEmailForm(
          names: [],
          onSave: (context, email) {
            
            setState(() {
              if (widget.landlordInfo.emails.where((element) => element.email == email).isNotEmpty) {
                return;
              }
              EmailInfo emailInfo = EmailInfo(email);
              widget.landlordInfo.emails.add(emailInfo);
            });
          },
        ));
  }
}
