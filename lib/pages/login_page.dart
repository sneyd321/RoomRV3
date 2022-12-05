import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/login_landlord.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/pages/navigation.dart';
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
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final LoginLandlord loginLandlord = LoginLandlord();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailTextEditingController.text = widget.email;
    passwordTextEditingController.text = widget.password;
    SharedPreferences.getInstance().then((value) {
      String? sharedPreferencesEmail = value.getString("email");
      if (sharedPreferencesEmail != null) {
        emailTextEditingController.text = sharedPreferencesEmail;
      }
    });
    FirebaseConfiguration()
        .getToken()
        .then((value) => loginLandlord.deviceId = value ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: MutationHelper(
        builder: (runMutation) {
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
                                  top: 16,
                                ),
                                child: const Center(
                                    child: Text(
                                  "RoomR",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 36),
                                ))),
                            const SizedBox(
                              height: 200,
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
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString("email", loginLandlord.email);
                                  runMutation({"login": loginLandlord.toJson()});
                                }
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
                                Navigation().navigateToSignUpPage(context);
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
        onComplete: (json) {
          Navigation().navigateToHousesPage(context, Landlord.fromJson(json));
        },
      ),
    );
  }
}
