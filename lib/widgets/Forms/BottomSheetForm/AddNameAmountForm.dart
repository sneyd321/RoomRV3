import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/business_logic/fields/number_field.dart';


import '../../FormFields/SuggestedFormField.dart';
import '../../buttons/CallToActionButton.dart';
import '../../buttons/SecondaryActionButton.dart';

class AddNameAmountForm extends StatefulWidget {
  final List<String> names;
  final void Function(BuildContext context, String name, String amount) onSave;
  
  const AddNameAmountForm({Key? key, required this.names, required this.onSave}) : super(key: key);

  @override
  State<AddNameAmountForm> createState() => _AddNameAmountFormState();
}

class _AddNameAmountFormState extends State<AddNameAmountForm> {
  final formKey = GlobalKey<FormState>();
  String name = "";
  String amount = "";
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
                label: "Name",
                icon: Icons.label,
                onSaved: (String? value) {
                  name = value!;
                },
                onValidate: (String? value) {
                  return Name(value!).validate();
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
                    labelText: "Amount",
                  ),
                  onSaved: (String? value) {
                    Amount number = Amount(value!);
                    amount = number.formatNumber(value);
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (String? value) {
                    return Amount(value!).validate();
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
                  ]),
            ),
             SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CallToActionButton(
                  text: "Add",
                  onClick: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      widget.onSave(context, name, amount);
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
