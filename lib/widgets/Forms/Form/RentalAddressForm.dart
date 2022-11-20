import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/services/network.dart';
import 'package:notification_app/services/stream_socket.dart';
import 'package:notification_app/widgets/FormFields/SuggestedFormField.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';
import 'package:notification_app/widgets/Helper/TextHelper.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/ParkingDescriptions.dart';

import '../../../business_logic/address.dart';
import '../../../business_logic/suggested_address.dart';
import '../../FormFields/AddressFormField.dart';
import '../../FormFields/SimpleFormField.dart';

class RentalAddressForm extends StatefulWidget {
  final RentalAddress rentalAddress;
  final GlobalKey<FormState> formKey;
  final bool isTest;

  const RentalAddressForm({
    Key? key,
    required this.rentalAddress,
    required this.formKey, this.isTest = false,
  }) : super(key: key);

  @override
  State<RentalAddressForm> createState() => _RentalAddressFormState();
}

class _RentalAddressFormState extends State<RentalAddressForm> {
  final TextEditingController streetNumberTextEditingController =
      TextEditingController();
  final TextEditingController streetNameTextEditingController =
      TextEditingController();
  final TextEditingController cityTextEditingController =
      TextEditingController();
  final TextEditingController provinceTextEditingController =
      TextEditingController();
  final TextEditingController postalCodeTextEditingController =
      TextEditingController();
  final TextEditingController unitNameTextEditingController =
      TextEditingController();

  final StreamSocket streamSocket = StreamSocket();
  final ScrollController scrollController = ScrollController();

  void onSuggestedAddress(
      BuildContext context, SuggestedAddress suggestedAddress, bool isTest) async {
    PredictedAddress address =
        await Network().getPredictedAddress(suggestedAddress.placesId);

    setState(() {
      streetNumberTextEditingController.text = address.streetNumber;
      streetNameTextEditingController.text = address.streetName;
      cityTextEditingController.text = address.city;
      provinceTextEditingController.text = address.province;
      postalCodeTextEditingController.text = address.postalCode;
      streamSocket.addResponse([]);
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    streetNumberTextEditingController.text = widget.rentalAddress.streetNumber;
    streetNameTextEditingController.text = widget.rentalAddress.streetName;
    cityTextEditingController.text = widget.rentalAddress.city;
    provinceTextEditingController.text = widget.rentalAddress.province;
    postalCodeTextEditingController.text = widget.rentalAddress.postalCode;
    unitNameTextEditingController.text = widget.rentalAddress.unitName;
  }

  @override
  void dispose() {
    super.dispose();
    streetNumberTextEditingController.dispose();
    cityTextEditingController.dispose();
    provinceTextEditingController.dispose();
    postalCodeTextEditingController.dispose();
    unitNameTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child:
          ListView(controller: scrollController, shrinkWrap: true, children: [
            Row(children: const [
            Icon(Icons.lightbulb, color: Colors.blue,),
            Text("This is the address you will rent to the tenant", softWrap: true,)
          ],),
        AddressFormField(onSuggestedAddress, streamSocket, isTest: widget.isTest),
        TwoColumnRow(
            left: SimpleFormField(
              label: "Street Number",
              icon: Icons.numbers,
              textEditingController: streetNumberTextEditingController,
              onSaved: (String? value) {
                widget.rentalAddress.setStreetNumber(value!);
              },
              field: StreetName(""),
            ),
            right: SimpleFormField(
              label: "Street Name",
              textEditingController: streetNameTextEditingController,
              icon: Icons.route,
              onSaved: (String? value) {
                widget.rentalAddress.setStreetName(value!);
              },
              field: StreetName(""),
            )),
        TwoColumnRow(
            left: SimpleFormField(
              label: "City",
              icon: Icons.location_city,
              textEditingController: cityTextEditingController,
              onSaved: (String? value) {
                widget.rentalAddress.setCity(value!);
              },
              field: City(""),
            ),
            right: SimpleFormField(
              label: "Province",
              icon: Icons.location_on,
              textEditingController: provinceTextEditingController,
              onSaved: (String? value) {
                widget.rentalAddress.setProvince(value!);
              },
              field: Province(""),
            )),
        Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
                width: (MediaQuery.of(context).size.width / 3) * 2,
                child: SimpleFormField(
                  label: "Postal Code",
                  icon: Icons.markunread_mailbox,
                  textEditingController: postalCodeTextEditingController,
                  onSaved: (String? value) {
                    widget.rentalAddress.setPostalCode(value!);
                  },
                 field: PostalCode(""),
                ))),
        Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: const TextHelper(text: "Is the rental unit a condominum?")),
        CheckboxListTile(
            value: widget.rentalAddress.isCondo,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(widget.rentalAddress.isCondo ? "Yes" : "No"),
            onChanged: (value) {
              setState(() {
                 widget.rentalAddress.setIsCondo(value!);
              });
             
            }),
        SuggestedFormField(
          icon: Icons.label,
          label: "Unit Name",
          textEditingController: unitNameTextEditingController,
          onSaved: (String? value) {
            widget.rentalAddress.setUnitName(value!);
          },
          onValidate: (String? value) {
            return UnitName(value!).validate();
          },
          suggestedNames: const ["Basement Unit", "Suite #", "Apt. #"],
        ),
        Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: const TextHelper(
                text: "Number of vehicle parking spaces and description")),
        ParkingDescriptionsList(
          rentalAddress: widget.rentalAddress,
        ),
      ]),
    );
  }
}
