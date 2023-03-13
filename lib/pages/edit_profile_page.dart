import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/buttons/CallToActionButton.dart';

import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/services/network.dart';
import 'package:notification_app/services/stream_socket.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../graphql/mutation_helper.dart';
import '../services/web_network.dart';

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

  void onSuggestedAddress(
       SuggestedAddress suggestedAddress) async {
    PredictedAddress address;
    if (kIsWeb) {
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
    streetNumberTextEditingController.text = landlord.streetNumber;
    streetNameTextEditingController.text = landlord.streetName;
    cityTextEditingController.text = landlord.city;
    provinceTextEditingController.text = landlord.province;
    postalCodeTextEditingController.text = landlord.postalCode;
    unitNumberTextEditingController.text = landlord.unitNumber;
    poBoxTextEditingController.text = landlord.poBox;
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
                    /*
                    SimpleFormField(
                      label: "First Name",
                      icon: Icons.account_circle,
                      textEditingController: firstNameTextEditingController,
                      onSaved: (value) {
                        landlord.updateFirstName(value!);
                      },
                      onValidate: (String? value) {
                        return landlord.updateFirstName(value!);
                      },
                    ),
                    SimpleFormField(
                      label: "Last Name",
                      icon: Icons.account_circle,
                      textEditingController: lastNameTextEditingController,
                      onSaved: (value) {
                        landlord.updateLastName(value!);
                      },
                      onValidate: (String? value) {
                        return landlord.updateLastName(value!);
                      },
                    ),
                    SimpleFormField(
                      label: "Phone Number",
                      icon: Icons.phone,
                      textEditingController: phoneNumberTextEditingController,
                      onSaved: (value) {
                        landlord.updatePhoneNumber(value!);
                      },
                      onValidate: (value) {
                        return landlord.updatePhoneNumber(value!);
                      },
                    ),
                    SimpleFormField(
                      textEditingController: emailTextEditingController,
                      onSaved: (value) {
                        landlord.updateEmail(value!);
                      },
                      icon: Icons.email,
                      label: 'Email',
                      onValidate: (String? value) {
                        return landlord.updateEmail(value!);
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
                    SimpleFormField(
                      label: "Street Number",
                      icon: Icons.numbers,
                      textEditingController: streetNumberTextEditingController,
                      onSaved: (String? value) {
                        landlord.updateStreetNumber(value!);
                      },
                      onValidate: (value) {
                        return landlord.updateStreetNumber(value!);
                      },
                    ),
                    SimpleFormField(
                      label: "Street Name",
                      textEditingController: streetNameTextEditingController,
                      icon: Icons.route,
                      onSaved: (String? value) {
                        landlord.updateStreetName(value!);
                      },
                      onValidate: (String? value) {
                        return landlord.updateStreetName(value!);
                      },
                    ),
                    SimpleFormField(
                          label: "City",
                          icon: Icons.location_city,
                          textEditingController: cityTextEditingController,
                          onSaved: (String? value) {
                            landlord.updateCity(value!);
                          },
                          onValidate: (value) {
                            return landlord.updateCity(value!);
                          },
                        ),
                        SimpleFormField(
                          label: "Province",
                          icon: Icons.location_on,
                          textEditingController: provinceTextEditingController,
                          onSaved: (String? value) {
                            landlord.updateProvince(value!);
                          },
                          onValidate: (value) {
                            return landlord.updateProvince(value!);
                          },
                        ),
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
                                  landlord
                                      .updatePostalCode(value!);
                                },
                                onValidate: (value) {
                                  return landlord
                                      .updatePostalCode(value!);
                                },))),
                    SimpleFormField(
                          label: "Unit Number",
                          icon: Icons.numbers,
                          textEditingController:
                              unitNumberTextEditingController,
                          onSaved: (String? value) {
                            landlord.
                                updateUnitNumber(value!);
                          },
                          onValidate: (value) {
                            return landlord.
                                updateUnitNumber(value!);
                          },
                        ),
                        SimpleFormField(
                          label: "P.O. Box",
                          icon: Icons.markunread_mailbox,
                          textEditingController: poBoxTextEditingController,
                          onSaved: (String? value) {
                            landlord.updatePoBox(value!);
                          },
                          onValidate: (value) {
                            return landlord.updatePoBox(value!);
                          },
                        ),
                        */
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
                                      "landlord": landlord.toLandlordInput("")
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
