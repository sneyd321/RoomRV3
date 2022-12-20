import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';

import '../../buttons/SecondaryButton.dart';
import '../../buttons/Button.dart';

class FormAddButtonRow extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(BuildContext context) onAdd;
  

  const FormAddButtonRow(
      {Key? key, required this.formKey, required this.onAdd})
      : super(key: key);

  @override
  State<FormAddButtonRow> createState() => _FormAddButtonRowState();
}

class _FormAddButtonRowState extends State<FormAddButtonRow> {


  @override
  Widget build(BuildContext context) {
    return TwoColumnRow(
        left: SecondaryButton(Icons.chevron_left, "Back", (context) {
          Navigator.of(context).pop();
        }),
        right: Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16),
            child: ElevatedButton(
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                    widget.formKey.currentState!.save();
                    widget.onAdd(context);
                  }
                },
                child: const Button(iconData: Icons.add, text: "Save", color: Colors.white))));
  }
}
