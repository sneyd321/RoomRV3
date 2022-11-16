import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/business_logic/suggested_address.dart';
import 'package:notification_app/services/network.dart';
import 'package:notification_app/services/stream_socket.dart';
import 'package:notification_app/services/web_network.dart';
import 'package:notification_app/widgets/FormFields/AddressFormField.dart';
import '../../../business_logic/address.dart';
import '../../FormFields/SimpleFormField.dart';
import '../FormRow/TwoColumnRow.dart';

class LandlordAddressForm extends StatefulWidget {
  final LandlordAddress landlordAddress;
  final GlobalKey<FormState> formKey;
  final StreamSocket streamSocket = StreamSocket();
  final bool isTest;
  LandlordAddressForm(
      {Key? key,
      required this.landlordAddress,
      required this.formKey,
      this.isTest = false})
      : super(key: key);

  void testAddAddressToStream(dynamic address) {
    streamSocket.addResponse(address);
  }

  @override
  State<LandlordAddressForm> createState() => _LandlordAddressFormState();
}

class _LandlordAddressFormState extends State<LandlordAddressForm> {
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
  final TextEditingController unitNumberTextEditingController =
      TextEditingController();
  final TextEditingController poBoxTextEditingController =
      TextEditingController();

  final ScrollController scrollController = ScrollController();

  void onSuggestedAddress(BuildContext context,
      SuggestedAddress suggestedAddress, bool isTest) async {
    PredictedAddress address;
    if (isTest) {
      address = PredictedAddress.fromJson({"streetNumber": "123", "streetName": "Queen Street West", "city": "Toronto", "province": "Ontario", "postalCode": "M5H 2M9"});
    }
    else if (kIsWeb) {
      address =
          await WebNetwork().getPredictedAddress(suggestedAddress.placesId);
    } else {
      address = await Network().getPredictedAddress(suggestedAddress.placesId);
    }
    streetNumberTextEditingController.text = address.streetNumber;
    streetNameTextEditingController.text = address.streetName;
    cityTextEditingController.text = address.city;
    provinceTextEditingController.text = address.province;
    postalCodeTextEditingController.text = address.postalCode;

    setState(() {
      widget.streamSocket.addResponse([]);
    });
  }

  @override
  void initState() {
    super.initState();
    streetNumberTextEditingController.text =
        widget.landlordAddress.streetNumber;
    streetNameTextEditingController.text = widget.landlordAddress.streetName;
    cityTextEditingController.text = widget.landlordAddress.city;
    provinceTextEditingController.text = widget.landlordAddress.province;
    postalCodeTextEditingController.text = widget.landlordAddress.postalCode;
    unitNumberTextEditingController.text = widget.landlordAddress.unitNumber;
    poBoxTextEditingController.text = widget.landlordAddress.poBox;
  }

  @override
  void dispose() {
    super.dispose();
    streetNumberTextEditingController.dispose();
    streetNameTextEditingController.dispose();
    cityTextEditingController.dispose();
    provinceTextEditingController.dispose();
    postalCodeTextEditingController.dispose();
    unitNumberTextEditingController.dispose();
    poBoxTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            AddressFormField(onSuggestedAddress, widget.streamSocket,
                isTest: widget.isTest),
            TwoColumnRow(
                left: SimpleFormField(
                  label: "Street Number",
                  icon: Icons.numbers,
                  textEditingController: streetNumberTextEditingController,
                  onSaved: (String? value) {
                    widget.landlordAddress.setStreetNumber(value!);
                  }, 
                  field: StreetNumber(""),
                ),
                right: SimpleFormField(
                  label: "Street Name",
                  textEditingController: streetNameTextEditingController,
                  icon: Icons.route,
                  onSaved: (String? value) {
                    widget.landlordAddress.setStreetName(value!);
                  },
                  field: StreetName(""),
                )),
            TwoColumnRow(
                left: SimpleFormField(
                  label: "City",
                  icon: Icons.location_city,
                  textEditingController: cityTextEditingController,
                  onSaved: (String? value) {
                    widget.landlordAddress.setCity(value!);
                  },
                  field: City(""),
                ),
                right: SimpleFormField(
                  label: "Province",
                  icon: Icons.location_on,
                  textEditingController: provinceTextEditingController,
                  onSaved: (String? value) {
                    widget.landlordAddress.setProvince(value!);
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
                        widget.landlordAddress.setPostalCode(value!);
                      },
                      field: PostalCode("")
                    ))),
            TwoColumnRow(
                left: SimpleFormField(
                  label: "Unit Number",
                  icon: Icons.numbers,
                  textEditingController: unitNumberTextEditingController,
                  onSaved: (String? value) {
                    widget.landlordAddress.setUnitNumber(value!);
                  },
                  field: UnitNumber(""),
                ),
                right: SimpleFormField(
                  label: "P.O. Box",
                  icon: Icons.markunread_mailbox,
                  textEditingController: poBoxTextEditingController,
                  onSaved: (String? value) {
                    widget.landlordAddress.setPOBox(value!);
                  },
                  field: POBox(""),
                )),
          ],
        ));
  }
}
