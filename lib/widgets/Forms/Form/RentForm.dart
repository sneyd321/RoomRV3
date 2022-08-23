import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/business_logic/fields/number_field.dart';
import 'package:notification_app/business_logic/rent.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/PaymentOptionsList.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/RentServicesList.dart';
import 'package:provider/provider.dart';

import '../../FormFields/SimpleFormField.dart';
import '../../Helper/TextHelper.dart';

class RentForm extends StatefulWidget {
  final Rent rent;
  final GlobalKey<FormState> formKey;
 
  const RentForm({Key? key,  required this.rent, required this.formKey,})
      : super(key: key);

  @override
  State<RentForm> createState() => _RentFormState();
}

class _RentFormState extends State<RentForm> {
  final TextEditingController baseRentTextEditingController =
      TextEditingController();
  final TextEditingController rentMadePayableToTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    baseRentTextEditingController.text = widget.rent.baseRent;
    rentMadePayableToTextEditingController.text = widget.rent.rentMadePayableTo;
  }

  @override
  void dispose() {
    super.dispose();
    baseRentTextEditingController.dispose();
    rentMadePayableToTextEditingController.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    return Consumer<Rent>(builder: (BuildContext context, Rent rent, child) {
      return Form(
        key: widget.formKey,
        child: Column(children: [
          const TextHelper(text: "The tenant will pay the following rent:"),
          Container(
            margin:
                const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0, top: 8),
            child: TextFormField(
                controller: baseRentTextEditingController,
                keyboardType: TextInputType.number,
                maxLines: null,
                
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  prefixIcon: Icon(Icons.monetization_on),
                  
                  labelText: "Base Rent",
                ),
                onSaved: (String? value) {
                  widget.rent.setBaseRent(value!);
                  
                },
                onChanged: (value) {
                  rent.setBaseRent(value);
                },
                validator: (String? value) {
                  return BaseRent(value).validate();
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]')),
                ]),
          ),
          SimpleFormField(
            textEditingController: rentMadePayableToTextEditingController,
            label: "Rent Made Payable To",
            icon: Icons.account_circle,
            onSaved: (String? value) {
              widget.rent.setRentMadePayableTo(value!);
             
            },
            onValidate: (String? value) {
              return RentMadePayableTo(value!).validate();
            },
          ),
          TextHelper(text: "Total Lawful rent: \$${rent.getTotalLawfulRent()}"),
          RentServicesList(rent: rent),
          const TextHelper(
              text: "Rent will be paid using the following methods:"),
          PaymentOptionsList(paymentOptions: rent.paymentOptions),
          
        ]),
      );
    });
  }
}
