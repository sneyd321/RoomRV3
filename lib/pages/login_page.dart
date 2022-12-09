import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/login_landlord.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/main.dart';
import 'package:notification_app/widgets/Navigation/navigation.dart';
import 'package:notification_app/widgets/Buttons/CallToActionButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../business_logic/fields/field.dart';
import '../business_logic/landlord.dart';
import '../services/FirebaseConfig.dart';
import '../graphql/graphql_client.dart';
import '../widgets/Buttons/SecondaryActionButton.dart';
import '../widgets/FormFields/EmailFormField.dart';
import '../widgets/FormFields/PasswordFormField.dart';

class LoginPage extends StatefulWidget {
  final String email;
  final String password;

  const LoginPage({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLoggedIn = false;

  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  
  LoginLandlord loginLandlord = LoginLandlord();
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late MultiSourceResult<Object?> Function(Map<String, dynamic>,
      {Object? optimisticResult}) runMutation;

  @override
  void initState() {
    super.initState();
    saveEmailPassword(widget.email, widget.password);
    FirebaseConfiguration()
        .getToken()
        .then((value) => loginLandlord.deviceId = value ?? "");
  }



  void saveEmailPassword(String email, String password) {
    emailTextEditingController.text = email;
    passwordTextEditingController.text = password;
    SharedPreferences.getInstance().then((value) {
      String? sharedPreferencesEmail = value.getString("email");
      if (sharedPreferencesEmail != null) {
        emailTextEditingController.text = sharedPreferencesEmail;
      }
    });
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email", loginLandlord.email);
      runMutation({"login": loginLandlord.toJson()});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: MutationHelper(
        builder: (runMutation) {
          this.runMutation = runMutation;
          return SafeArea(
              child: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                  top: 32,
                                ),
                                child: Center(
                                    child: Column(
                                  children: const [
                                    Text(
                                      "Room Renting",
                                      style: TextStyle(
                                          color: Color(primaryColour),
                                          fontSize: 36),
                                    ),
                                    Text(
                                      "Landlord",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 28),
                                    ),
                                  ],
                                ))),
                            const SizedBox(
                              height: 128,
                            ),
                            EmailFormField(
                              textEditingController: emailTextEditingController,
                              onSaved: ((email) {
                                loginLandlord.setEmail(email);
                              }),
                            ),
                            PasswordFormField(
                                textEditingController:
                                    passwordTextEditingController,
                                onSaved: (value) {
                                  loginLandlord.setPassword(value!);
                                },
                                label: "Password",
                                icon: Icons.lock,
                                onValidate: (value) {
                                  return Password(value!).validate();
                                }),
                          ],
                        )),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: CallToActionButton(
                              text: "Login",
                              onClick: () async {
                                login();
                              }),
                        )
                      ]),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(children: [
                        Expanded(
                          child: SecondaryActionButton(
                              text: "Sign Up",
                              onClick: () async {
                                LoginLandlord? loginLandlord = await Navigation().navigateToSignUpPage(context);
                                if (loginLandlord != null) {
                                  this.loginLandlord.email = loginLandlord.email;
                                  this.loginLandlord.password = loginLandlord.password;
                                  saveEmailPassword(loginLandlord.email, loginLandlord.password);
                                  login();
                                }
                              }),
                        )
                      ])
                    ],
                  ),
                ),
              ],
            ),
          ));
        },
        mutationName: 'loginLandlord',
        onComplete: (json) async {
          bool? result = await Navigation().navigateToHousesPage(context, Landlord.fromJson(json));
          print("On complete");
          print(result);
          if (result != null) return;
          
          login();
          

        },
      ),
    );
  }
}
