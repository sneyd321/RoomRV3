import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/widgets/Forms/FormRow/FormAddButtonRow.dart';


import '../../FormFields/SuggestedFormField.dart';

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
                label: "Title",
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
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    prefixIcon: Icon(Icons.monetization_on),
                    labelText: "Body",
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
            FormAddButtonRow(formKey: formKey, onAdd: (BuildContext context) { 
              widget.onSave(context, title.value, body.value);
             }, ),
          ]),
    );
  }
}
