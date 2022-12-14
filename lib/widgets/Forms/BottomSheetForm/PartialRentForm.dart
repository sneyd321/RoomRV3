import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../../FormFields/SimpleDatePicker.dart';
import '../../Helper/TextHelper.dart';
import '../../buttons/CallToActionButton.dart';
import '../../buttons/SecondaryActionButton.dart';

class PartialRentForm extends StatefulWidget {
  final void Function(BuildContext context, PartialPeriod partialPeriod) onSave;

  const PartialRentForm({Key? key, required this.onSave}) : super(key: key);

  @override
  State<PartialRentForm> createState() => _PartialRentFormState();
}

class _PartialRentFormState extends State<PartialRentForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PartialPeriod partialPeriod = PartialPeriod();
  @override
  Widget build(BuildContext context) {
    return  Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            const TextHelper(text: "The tenant will pay a partial rent of"),
            Container(
              margin: const EdgeInsets.all(8),
              child: TextFormField(
                  controller: TextEditingController(),
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
                    partialPeriod.setAmount(value!);
                  },
                  validator: (String? value) {
                    return Amount(value!).validate();
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
                  ]),
            ),
            const TextHelper(text: "On"),
            SimpleDatePicker(
              textEditingController: TextEditingController(),
              label: 'Due Date',
              onSaved: (String? value) {
                partialPeriod.setDueDate(value!);
              },
              onValidate: (String? value) {
                return DueDate(value!).validate();
              },
            ),
            const TextHelper(
                text: "The Partial Rent covers the rental of the unit from:"),
            TwoColumnRow(
                left: Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: SimpleDatePicker(
                      textEditingController: TextEditingController(),
                      label: 'Start Date',
                      onSaved: (String? value) {
                        partialPeriod.setStartDate(value!);
                      },
                      onValidate: (String? value) {
                        return StartDate(value!).validate();
                      },
                    )),
                right: Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: SimpleDatePicker(
                      textEditingController: TextEditingController(),
                      label: 'End Date',
                      onSaved: (String? value) {
                        partialPeriod.setEndDate(value!);
                      },
                      onValidate: (String? value) {
                        return EndDate(value!).validate();
                      },
                    ))),
                     SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CallToActionButton(
                  text: "Add",
                  onClick: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                     widget.onSave(context, partialPeriod);
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
           
          ],
        ),
      );
  
  }
}
