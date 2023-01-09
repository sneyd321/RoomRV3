import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../../buttons/CallToActionButton.dart';
import '../../buttons/SecondaryActionButton.dart';

class AddAmountForm extends StatefulWidget {
  final void Function(BuildContext context, String amount) onSave;
  
  const AddAmountForm({Key? key, required this.onSave}) : super(key: key);

  @override
  State<AddAmountForm> createState() => _AddAmountFormState();
}

class _AddAmountFormState extends State<AddAmountForm> {
  final formKey = GlobalKey<FormState>();
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
                  text: "Update Amount",
                  onClick: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      widget.onSave(context, amount);
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
