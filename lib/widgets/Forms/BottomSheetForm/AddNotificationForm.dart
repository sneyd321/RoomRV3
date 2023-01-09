import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


import '../../FormFields/SuggestedFormField.dart';
import '../../buttons/CallToActionButton.dart';
import '../../buttons/SecondaryActionButton.dart';

class AddNotificationForm extends StatefulWidget {
  final List<String> names;
  final void Function(BuildContext context, String title, String body) onSave;
  
  const AddNotificationForm({Key? key, required this.names, required this.onSave}) : super(key: key);

  @override
  State<AddNotificationForm> createState() => _AddNotificationFormState();
}

class _AddNotificationFormState extends State<AddNotificationForm> {
  final formKey = GlobalKey<FormState>();
  Field body = BodyField("");
  Field title = TitleField("");
  final TextEditingController textEditingController = TextEditingController();

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
                textEditingController: textEditingController,
                label: "Subject",
                icon: Icons.label,
                onSaved: (String? value) {
                  title = TitleField(value!);
                },
                onValidate: (String? value) {
                  return TitleField(value!).validate();
                },
                suggestedNames: widget.names,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    prefixIcon: Icon(Icons.subject),
                    labelText: "Content",
                  ),
                  onSaved: (String? value) {
                    body = BodyField(value!);
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (String? value) {
                    return BodyField(value!).validate();
                  },
                 ),
            ),
             Container(
              width: MediaQuery.of(context).size.width,
              child: CallToActionButton(
                  text: "Add",
                  onClick: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      widget.onSave(context, title.value, body.value);
                    }
                  }),
            ),
            Container(
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
