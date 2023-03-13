import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/bloc/fields/PasswordFormField.dart';
import 'package:notification_app/buttons/CallToActionButton.dart';


import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/services/network.dart';
import 'package:notification_app/services/stream_socket.dart';

import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../graphql/mutation_helper.dart';
import '../services/web_network.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Landlord landlord = Landlord();
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
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController reTypeTextEditingController =
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
    firstNameTextEditingController.text = landlord.firstName;
    lastNameTextEditingController.text = landlord.lastName;
    emailTextEditingController.text = landlord.email;
    phoneNumberTextEditingController.text = landlord.phoneNumber;
    passwordTextEditingController.text = landlord.password;
    reTypeTextEditingController.text = landlord.password;
    streetNumberTextEditingController.text =
        landlord.streetNumber;
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
    passwordTextEditingController.dispose();
    reTypeTextEditingController.dispose();
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
              title: const Text("Sign Up"),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                   
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: CallToActionButton(
                                text: "Create Account",
                                onClick: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    runMutation({
                                      "landlord":
                                          landlord.toCreateLandlordInput()
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
        mutationName: 'createLandlord',
        onComplete: (json) {
          Landlord landlord = Landlord.fromJson(json);
  
          landlord.updateEmail(landlord.email);
          landlord.updatePassword(password);
          Navigator.pop(context, landlord);
        },
      )),
    );
  }
}
