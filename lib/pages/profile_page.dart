import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notification_app/buttons/CallToActionButton.dart';
import 'package:notification_app/buttons/MemoryPhoto.dart';
import 'package:notification_app/buttons/ProfilePicture.dart';
import 'package:notification_app/dialog/delete_landlord_dialog.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/main.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../graphql/mutation_helper.dart';
import '../services/network.dart';
import '../services/stream_socket.dart';
import '../services/web_network.dart';


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
              return SingleChildScrollView(
                child: Column(
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
                              text: widget.landlord.fullName,
                              profileColor: Colors.blueGrey,
                              profileSize: 60,
                              iconSize: 80,
                              textSize: 18,
                              textColor: Color(primaryColour),
                              onClick: () async {
                                await openGallery(runMutation);
                              },
                            ),
                            child: ProfilePicture(
                                profileColor: Colors.blueGrey,
                                profileSize: 60,
                                icon: Icons.add_a_photo,
                                iconSize: 80,
                                textSize: 18,
                                profileURL: landlord.profileURL,
                                textColor: Color(primaryColour),
                                text: widget.landlord.fullName,
                                onClick: () async {
                                  await openGallery(runMutation);
                                }),
                          ),
                        );
                      },
                      mutationName: 'scheduleLandlordProfile',
                      onComplete: (json) {},
                    ),
                   
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      child: CallToActionButton(
                          text: "Update",
                          onClick: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              runMutation(
                                  {"landlord": landlord.toLandlordInput("")});
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
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteLandlordDialog(landlord: landlord);
                          },
                        );
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
                ),
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
