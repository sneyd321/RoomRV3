import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/business_logic/fields/number_field.dart';
import 'package:notification_app/business_logic/rent.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/RentServicesList.dart';

import '../../FormFields/SimpleFormField.dart';
import '../../Helper/TextHelper.dart';

class CreateHouseRentForm extends StatefulWidget {
  final Rent rent;
  final GlobalKey<FormState> formKey;

  const CreateHouseRentForm({
    Key? key,
    required this.rent,
    required this.formKey,
  }) : super(key: key);

  @override
  State<CreateHouseRentForm> createState() => _CreateHouseRentFormState();
}

class _CreateHouseRentFormState extends State<CreateHouseRentForm> {
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
                setState(() {
                  widget.rent.setBaseRent(value);
                  widget.rent.getTotalLawfulRent();
                });
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
          field: RentMadePayableTo(""),
        ),
        TextHelper(
            text: "Total Lawful Rent: \$${widget.rent.getTotalLawfulRent()}"),
        const SizedBox(
          height: 16,
        ),
        const TextHelper(
          text:
              "Other services and utilities the tenant will pay as part of total rent.",
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: Row(
            children: const [
              Icon(
                Icons.lightbulb,
                color: Colors.amber,
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                  child: Text(
                "Tap the amount to change the dollar value.\nRemoving a service means the service is not included in total rent.",
                softWrap: true,
              ))
            ],
          ),
        ),
        RentServicesList(
          rent: widget.rent,
          onAddRentService: ((context, rentService) {
            setState(() {
              widget.rent.getTotalLawfulRent();
            });
          }),
          onRemoveRentService: (context, rentService) {
            setState(() {
              widget.rent.getTotalLawfulRent();
            });
          },
        ),
      ]),
    );
  }
}
