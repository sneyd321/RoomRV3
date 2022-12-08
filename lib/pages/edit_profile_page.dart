import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/pages/login_page.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/services/network.dart';
import 'package:notification_app/services/stream_socket.dart';
import 'package:notification_app/widgets/Buttons/CallToActionButton.dart';
import 'package:notification_app/widgets/FormFields/EmailFormField.dart';
import 'package:notification_app/widgets/FormFields/PasswordFormField.dart';
import 'package:notification_app/widgets/FormFields/SimpleFormField.dart';

import '../business_logic/address.dart';
import '../business_logic/suggested_address.dart';
import '../graphql/mutation_helper.dart';
import '../services/web_network.dart';
import '../widgets/FormFields/AddressFormField.dart';
import '../widgets/Forms/FormRow/TwoColumnRow.dart';

class EditProfilePage extends StatefulWidget {
  final Landlord landlord;
  const EditProfilePage({Key? key, required this.landlord}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Landlord landlord;
  String password = "";
  final StreamSocket streamSocket = StreamSocket();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController lastNameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();

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
      address = PredictedAddress.fromJson({
        "streetNumber": "123",
        "streetName": "Queen Street West",
        "city": "Toronto",
        "province": "Ontario",
        "postalCode": "M5H 2M9"
      });
    } else if (kIsWeb) {
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
      streamSocket.addResponse([]);
    });
  }

  @override
  void initState() {
    super.initState();
    landlord = widget.landlord;
    firstNameTextEditingController.text = landlord.firstName;
    lastNameTextEditingController.text = landlord.lastName;
    emailTextEditingController.text = landlord.email;
    phoneNumberTextEditingController.text = landlord.phoneNumber;
    streetNumberTextEditingController.text =
        landlord.landlordAddress.streetNumber;
    streetNameTextEditingController.text = landlord.landlordAddress.streetName;
    cityTextEditingController.text = landlord.landlordAddress.city;
    provinceTextEditingController.text = landlord.landlordAddress.province;
    postalCodeTextEditingController.text = landlord.landlordAddress.postalCode;
    unitNumberTextEditingController.text = landlord.landlordAddress.unitNumber;
    poBoxTextEditingController.text = landlord.landlordAddress.poBox;
  }

  @override
  void dispose() {
    super.dispose();
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    emailTextEditingController.dispose();
    phoneNumberTextEditingController.dispose();

    //
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
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: SafeArea(
          child: MutationHelper(
        builder: (runMutation) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Edit Profile"),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TwoColumnRow(
                        left: SimpleFormField(
                          label: "First Name",
                          icon: Icons.account_circle,
                          textEditingController: firstNameTextEditingController,
                          onSaved: (value) {
                            landlord.setFirstName(value!.trim());
                          },
                          field: Name(""),
                        ),
                        right: SimpleFormField(
                          label: "Last Name",
                          icon: Icons.account_circle,
                          textEditingController: lastNameTextEditingController,
                          onSaved: (value) {
                            landlord.setLastName(value!.trim());
                          },
                          field: Name(""),
                        )),
                    SimpleFormField(
                        label: "Phone Number",
                        icon: Icons.phone,
                        textEditingController: phoneNumberTextEditingController,
                        onSaved: (value) {
                          landlord.setPhoneNumber(value!.trim());
                        },
                        field: Name("")),
                    EmailFormField(
                      textEditingController: emailTextEditingController,
                      onSaved: (value) {
                        landlord.setEmail(value.trim());
                      },
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
                            "This is the address for recieving notices or documents from your tenants",
                            softWrap: true,
                          ))
                        ],
                      ),
                    ),
                    AddressFormField(onSuggestedAddress, streamSocket),
                    TwoColumnRow(
                        left: SimpleFormField(
                          label: "Street Number",
                          icon: Icons.numbers,
                          textEditingController:
                              streetNumberTextEditingController,
                          onSaved: (String? value) {
                            landlord.landlordAddress
                                .setStreetNumber(value!.trim());
                          },
                          field: StreetNumber(""),
                        ),
                        right: SimpleFormField(
                          label: "Street Name",
                          textEditingController:
                              streetNameTextEditingController,
                          icon: Icons.route,
                          onSaved: (String? value) {
                            landlord.landlordAddress
                                .setStreetName(value!.trim());
                          },
                          field: StreetName(""),
                        )),
                    TwoColumnRow(
                        left: SimpleFormField(
                          label: "City",
                          icon: Icons.location_city,
                          textEditingController: cityTextEditingController,
                          onSaved: (String? value) {
                            landlord.landlordAddress.setCity(value!.trim());
                          },
                          field: City(""),
                        ),
                        right: SimpleFormField(
                          label: "Province",
                          icon: Icons.location_on,
                          textEditingController: provinceTextEditingController,
                          onSaved: (String? value) {
                            landlord.landlordAddress.setProvince(value!.trim());
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
                                textEditingController:
                                    postalCodeTextEditingController,
                                onSaved: (String? value) {
                                  landlord.landlordAddress
                                      .setPostalCode(value!.trim());
                                },
                                field: PostalCode("")))),
                    TwoColumnRow(
                        left: SimpleFormField(
                          label: "Unit Number",
                          icon: Icons.numbers,
                          textEditingController:
                              unitNumberTextEditingController,
                          onSaved: (String? value) {
                            landlord.landlordAddress
                                .setUnitNumber(value!.trim());
                          },
                          field: UnitNumber(""),
                        ),
                        right: SimpleFormField(
                          label: "P.O. Box",
                          icon: Icons.markunread_mailbox,
                          textEditingController: poBoxTextEditingController,
                          onSaved: (String? value) {
                            landlord.landlordAddress.setPOBox(value!.trim());
                          },
                          field: POBox(""),
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: CallToActionButton(
                                text: "Update",
                                onClick: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    runMutation({
                                      "landlord":
                                          landlord.toLandlordJson()
                                    });
                                  }
                                }),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        mutationName: 'updateLandlord',
        onComplete: (json) {
          Navigator.pop<Landlord>(context, Landlord.fromJson(json));
        },
      )),
    );
  }
}
