import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord_info.dart';
import 'package:notification_app/widgets/FormFields/SimpleFormField.dart';
import 'package:notification_app/widgets/Helper/TextHelper.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/ContactsList.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/EmailsList.dart';

import '../../../business_logic/fields/field.dart';

class LandlordInfoForm extends StatefulWidget {
  final LandlordInfo landlordInfo;
  final GlobalKey<FormState> formKey;

  const LandlordInfoForm({
    Key? key,
    required this.landlordInfo,
    required this.formKey,
  }) : super(key: key);

  @override
  State<LandlordInfoForm> createState() => _LandlordInfoFormState();
}

class _LandlordInfoFormState extends State<LandlordInfoForm> {
  final TextEditingController fullNameTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    fullNameTextEditingController.text = widget.landlordInfo.fullName;
  }

  @override
  void dispose() {
    super.dispose();
    fullNameTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(children: [
        SimpleFormField(
          icon: Icons.account_circle,
          label: "Full Name",
          onSaved: (value) {
            widget.landlordInfo.setFullName(value!);
          },
          field: Name(""),
          textEditingController: fullNameTextEditingController,
        ),
        Container(
          margin: const EdgeInsets.only(left: 8, right: 8),
          child: const TextHelper(
              text:
                  "Both the landlord and tenant agree to recieve notices and documents by email where allowed by the Landlord and Tenant Board's Rules and Practice."),
        ),
        CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: widget.landlordInfo.receiveDocumentsByEmail,
            title: const Text("If yes, provide email address"),
            onChanged: (value) {
              setState(() {
                widget.landlordInfo.setReceiveDocumentsByEmail(value!);
              });
            }),
        Visibility(
            visible: widget.landlordInfo.receiveDocumentsByEmail,
            child: EmailsList(
              landlordInfo: widget.landlordInfo,
            )),
        Container(
          margin: const EdgeInsets.only(left: 8, right: 8),
          child: const TextHelper(
              text:
                  "The landlord is providing phone and/or email contact information for emergencies or day-to-day communications"),
        ),
        CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: widget.landlordInfo.contactInfo,
            title: const Text("If yes, provide information"),
            onChanged: (value) {
              setState(() {
                widget.landlordInfo.setContactInfo(value!);
              });
            }),
        Visibility(
            visible: widget.landlordInfo.contactInfo,
            child: ContactsList(
              landlordInfo: widget.landlordInfo,
            )),
      ]),
    );
  }
}
