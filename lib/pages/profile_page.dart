import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/main.dart';
import 'package:notification_app/widgets/Buttons/CallToActionButton.dart';
import 'package:notification_app/widgets/Buttons/MemoryPhoto.dart';
import 'package:notification_app/widgets/Buttons/ProfilePicture.dart';

import '../business_logic/address.dart';
import '../business_logic/fields/field.dart';
import '../business_logic/house.dart';
import '../business_logic/suggested_address.dart';
import '../graphql/mutation_helper.dart';
import '../services/network.dart';
import '../services/stream_socket.dart';
import '../services/web_network.dart';
import '../widgets/FormFields/AddressFormField.dart';
import '../widgets/FormFields/EmailFormField.dart';
import '../widgets/FormFields/SimpleFormField.dart';
import '../widgets/Forms/FormRow/TwoColumnRow.dart';

class ProfilePage extends StatefulWidget {
  final Landlord landlord;

  const ProfilePage({Key? key, required this.landlord}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  ImagePicker picker = ImagePicker();
  XFile? image;

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
    landlord = widget.landlord;
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

  void showDeleteProfileDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return GraphQLProvider(
          client: GQLClient().getClient(),
          child: MutationHelper(
            builder: (runMutation) {
              return AlertDialog(
                  actions: [
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        runMutation({"landlord": landlord.toLandlordJson()});
                      },
                    ),
                  ],
                  content: Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.warning,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          "This will delete your account but but not your properties.\nThis means tenants will still have access to your properties but you will not.\nDo you still want to delete your account?",
                          softWrap: true,
                        ),
                      ),
                    ],
                  ));
            },
            mutationName: 'deleteLandlord',
            onComplete: (json) {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        );
      },
    );
  }

  Future<void> openGallery(
      MultiSourceResult<Object?> Function(Map<String, dynamic>,
              {Object? optimisticResult})
          runMutation) async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      runMutation({
        "houseKey": "",
        "landlordProfile": {
          "firstName": landlord.firstName,
          "lastName": landlord.lastName,
          "imageURL": landlord.profileURL
        },
        "image": base64Encode(await image!.readAsBytes())
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
          ),
          body: MutationHelper(
            builder: (runMutation) {
              return ListView(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  MutationHelper(
                    builder: (runMutation) {
                      return Center(
                        child: Visibility(
                          visible: image == null,
                          replacement: MemoryPhoto(
                            bytes: image?.readAsBytes(),
                            text: widget.landlord.getFullName(),
                            profileColor: Colors.blueGrey,
                            profileSize: 60,
                            iconSize: 80,
                            textSize: 18,
                            textColor: Color(primaryColour),
                            onClick: () async {await openGallery(runMutation);},
                          ),
                          child: ProfilePicture(
                              profileColor: Colors.blueGrey,
                              profileSize: 60,
                              icon: Icons.add_a_photo,
                              iconSize: 80,
                              textSize: 18,
                              profileURL: landlord.profileURL,
                              textColor: Color(primaryColour),
                              text: widget.landlord.getFullName(),
                              onClick: () async {
                                await openGallery(runMutation);
                              }),
                        ),
                      );
                    },
                    mutationName: 'scheduleLandlordProfile',
                    onComplete: (json) {},
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TwoColumnRow(
                              left: SimpleFormField(
                                label: "First Name",
                                icon: Icons.account_circle,
                                textEditingController:
                                    firstNameTextEditingController,
                                onSaved: (value) {
                                  landlord.setFirstName(value!.trim());
                                },
                                field: Name(""),
                              ),
                              right: SimpleFormField(
                                label: "Last Name",
                                icon: Icons.account_circle,
                                textEditingController:
                                    lastNameTextEditingController,
                                onSaved: (value) {
                                  landlord.setLastName(value!.trim());
                                },
                                field: Name(""),
                              )),
                          SimpleFormField(
                              label: "Phone Number",
                              icon: Icons.phone,
                              textEditingController:
                                  phoneNumberTextEditingController,
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
                                textEditingController:
                                    cityTextEditingController,
                                onSaved: (String? value) {
                                  landlord.landlordAddress
                                      .setCity(value!.trim());
                                },
                                field: City(""),
                              ),
                              right: SimpleFormField(
                                label: "Province",
                                icon: Icons.location_on,
                                textEditingController:
                                    provinceTextEditingController,
                                onSaved: (String? value) {
                                  landlord.landlordAddress
                                      .setProvince(value!.trim());
                                },
                                field: Province(""),
                              )),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width / 3) *
                                          2,
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
                                textEditingController:
                                    poBoxTextEditingController,
                                onSaved: (String? value) {
                                  landlord.landlordAddress
                                      .setPOBox(value!.trim());
                                },
                                field: POBox(""),
                              ))
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    child: CallToActionButton(
                        text: "Update",
                        onClick: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            runMutation(
                                {"landlord": landlord.toLandlordJson()});
                          }
                        }),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.red,
                    indent: 8,
                    endIndent: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDeleteProfileDialog();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: const ListTile(
                        title: Text(
                          "Delete Profile",
                          style: TextStyle(color: Colors.red),
                        ),
                        trailing: Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            mutationName: 'updateLandlord',
            onComplete: (json) {
              Navigator.pop<Landlord>(context, Landlord.fromJson(json));
            },
          ),
        ),
      ),
    );
  }
}
