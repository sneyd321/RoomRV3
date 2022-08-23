import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/services/network.dart';
import 'package:notification_app/services/stream_socket.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/FormFields/SuggestedFormField.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';
import 'package:notification_app/widgets/Helper/TextHelper.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/ParkingDescriptions.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/address.dart';
import '../../../business_logic/suggested_address.dart';
import '../../FormFields/AddressFormField.dart';
import '../../FormFields/SimpleFormField.dart';

class RentalAddressForm extends StatefulWidget {
  final RentalAddress rentalAddress;
  final GlobalKey<FormState> formKey;
  

  const RentalAddressForm({
    Key? key,
    required this.rentalAddress, required this.formKey,
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
      BuildContext context, SuggestedAddress suggestedAddress) async {
    RentalAddress address = await Network()
        .getRentalAddress(suggestedAddress.placesId);

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
    return Consumer<RentalAddress>(
      builder: (BuildContext context, RentalAddress rentalAddress, child) {
        return Form(
              key: widget.formKey,
              child: ListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  children: [
                    AddressFormField(onSuggestedAddress, streamSocket),
                    TwoColumnRow(
                        left: SimpleFormField(
                          label: "Street Number",
                          icon: Icons.numbers,
                          textEditingController:
                              streetNumberTextEditingController,
                          onSaved: (String? value) {
                            widget.rentalAddress.setStreetNumber(value!);
                           
                          },
                          onValidate: (String? value) {
                            return StreetNumber(value!).validate();
                          },
                        ),
                        right: SimpleFormField(
                          label: "Street Name",
                          textEditingController:
                              streetNameTextEditingController,
                          icon: Icons.route,
                          onSaved: (String? value) {
                           widget.rentalAddress.setStreetName(value!);
                          
                          },
                          onValidate: (String? value) {
                            return StreetName(value!).validate();
                          },
                        )),
                    TwoColumnRow(
                        left: SimpleFormField(
                          label: "City",
                          icon: Icons.location_city,
                          textEditingController: cityTextEditingController,
                          onSaved: (String? value) {
                            widget.rentalAddress.setCity(value!);
                           
                          },
                          onValidate: (String? value) {
                            return City(value!).validate();
                          },
                        ),
                        right: SimpleFormField(
                          label: "Province",
                          icon: Icons.location_on,
                          textEditingController: provinceTextEditingController,
                          onSaved: (String? value) {
                            widget.rentalAddress.setProvince(value!);
                           
                          },
                          onValidate: (String? value) {
                            return Province(value!).validate();
                          },
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                            width: (MediaQuery.of(context).size.width / 3) * 2,
                            child: SimpleFormField(
                              label: "Postal Code",
                              icon: Icons.markunread_mailbox,
                              textEditingController:
                                  postalCodeTextEditingController,
                              onSaved: (String? value) {
                                widget.rentalAddress.setPostalCode(value!);
                               
                              },
                              onValidate: (String? value) {
                                return PostalCode(value!).validate();
                              },
                            ))),
                    Container(
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: const TextHelper(
                            text: "Is the rental unit a condominum?")),
                    CheckboxListTile(
                        value: rentalAddress.isCondo,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(rentalAddress.isCondo ? "Yes" : "No"),
                        onChanged: (value) {
                          rentalAddress.setIsCondo(value!);
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
                      suggestedNames: const [
                        "Basement Unit",
                        "Suite #",
                        "Apt. #"
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: const TextHelper(
                            text:
                                "Number of vehicle parking spaces and description")),
                    ParkingDescriptionsList(
                      parkingDescriptions: rentalAddress.parkingDescriptions,
                    ),
                    
                  ]),
        );
      },
    );
  }
}
