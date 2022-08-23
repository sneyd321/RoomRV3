import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/widgets/Forms/FormRow/FormAddButtonRow.dart';

import '../../FormFields/SuggestedFormField.dart';

class AddNameForm extends StatefulWidget {
  final Function(BuildContext context, String name) onSave;
  final List<String> names;
  final label;
  

  const AddNameForm({
    Key? key,
    required this.onSave, required this.names, this.label = "Name"
  }) : super(key: key);

  @override
  State<AddNameForm> createState() => _AddNameFormState();
}

class _AddNameFormState extends State<AddNameForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = "";
  
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
                label: widget.label,
                textEditingController: TextEditingController(),
                icon: Icons.label,
                onSaved: (String? value) {
                  name = value!;
                },
                onValidate: (String? value) {
                  return Name(value!).validate();
                },
                suggestedNames: widget.names
              ),
            ),
            FormAddButtonRow(formKey: formKey, onAdd: (BuildContext context) {
              widget.onSave(context, name);
            })
            
          ]),
    );
  }
}
