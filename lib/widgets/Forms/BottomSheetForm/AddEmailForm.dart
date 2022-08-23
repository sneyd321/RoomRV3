

import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/widgets/Forms/FormRow/FormAddButtonRow.dart';


import '../../FormFields/SuggestedFormField.dart';

class AddEmailForm extends StatefulWidget {
  final Function(BuildContext context, String email) onSave;
  final List<String> names;
  

  const AddEmailForm({
    Key? key,
    required this.onSave, required this.names
  }) : super(key: key);

  @override
  State<AddEmailForm> createState() => _AddEmailFormState();
}

class _AddEmailFormState extends State<AddEmailForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = "";
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: SuggestedFormField(
                textEditingController: TextEditingController(),
                label: "Email",
                icon: Icons.label,
                onSaved: (String? value) {
                  email = value!;
                },
                onValidate: (String? value) {
                  return Email(value!).validate();
                },
                suggestedNames: widget.names
              ),
            ),
            FormAddButtonRow(formKey: formKey, onAdd: (BuildContext context) {
              widget.onSave(context, email);
            })
            
          ]),
    );
  }
}
