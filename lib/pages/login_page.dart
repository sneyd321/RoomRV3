import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/bloc/fields/PasswordFormField.dart';
import 'package:notification_app/Navigation/navigation.dart';
import 'package:notification_app/buttons/CallToActionButton.dart';
import 'package:notification_app/bloc/helper/SecondaryActionButton.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/main.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/FirebaseConfig.dart';
import '../graphql/graphql_client.dart';

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
  Landlord landlord = Landlord();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late MultiSourceResult<Object?> Function(Map<String, dynamic>,
      {Object? optimisticResult}) runMutation;

  @override
  void initState() {
    super.initState();
    saveEmailPassword(widget.email, widget.password);
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
      prefs.setString("email", landlord.email);
      runMutation({
        "login": landlord
            .toLoginLandlordInput(await FirebaseConfiguration().getToken())
      });
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
                  body: Column(children: [
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
                            Landlord? landlord = await Navigation()
                                .navigateToSignUpPage(context);
                            if (landlord != null) {
                              this.landlord.updateEmail(landlord.email);
                              this.landlord.updatePassword(landlord.password);
                              saveEmailPassword(
                                  landlord.email, landlord.password);
                              login();
                            }
                          }),
                    )
                  ])
                ],
              ),
            ),
          ])));
        },
        mutationName: 'loginLandlord',
        onComplete: (json) async {
          bool? result = await Navigation()
              .navigateToHousesPage(context, Landlord.fromJson(json));

          if (result != null) return;

          login();
        },
      ),
    );
  }
}
