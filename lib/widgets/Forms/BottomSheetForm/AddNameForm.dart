import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../../FormFields/SuggestedFormField.dart';
import '../../buttons/CallToActionButton.dart';
import '../../buttons/SecondaryActionButton.dart';

class AddNameForm extends StatefulWidget {
  final Function(BuildContext context, String name) onSave;
  final List<String> names;
  final String label;
  

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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CallToActionButton(
                  text: "Add",
                  onClick: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      widget.onSave(context, name);
                    }
                  }),
            ),
            const SizedBox(height: 8,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SecondaryActionButton(
                  text: "Back",
                  onClick: () {
                    Navigator.pop(context);
                  }),
            ),
            
          ]),
    );
  }
}
