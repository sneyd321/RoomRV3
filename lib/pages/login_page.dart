import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/business_logic/login_landlord.dart';
import 'package:notification_app/pages/sign_up_page.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Dialogs/loading_dialog.dart';
import 'package:notification_app/widgets/mutations/mutation_button.dart';

import '../business_logic/fields/field.dart';
import '../services/FirebaseConfig.dart';
import '../services/graphql_client.dart';
import '../widgets/FormFields/EmailFormField.dart';
import '../widgets/FormFields/PasswordFormField.dart';
import '../widgets/Forms/FormRow/TwoColumnRow.dart';

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
  LoadingDialog loadingDialog = LoadingDialog();

  @override
  void initState() {
    super.initState();
    emailTextEditingController.text = widget.email;
    passwordTextEditingController.text = widget.password;
    FirebaseConfiguration()
        .getToken()
        .then((value) => loginLandlord.deviceId = value ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
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
                        style: TextStyle(color: Colors.blue, fontSize: 36),
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
                      textEditingController: passwordTextEditingController,
                      onSaved: (value) {
                        loginLandlord.setPassword(value!);
                      },
                      label: "Password",
                      icon: Icons.password,
                      onValidate: (value) {
                        return Password(value!).validate();
                      }),
                  TwoColumnRow(
                    left: SecondaryButton(Icons.account_box, "Sign Up",
                        (context) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    }),
                    right: MutationButton(
                      builder: (runMutation, result) {
                        return PrimaryButton(Icons.login, "Login", (context) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            runMutation({"login": loginLandlord.toJson()});
                            loadingDialog.show(context);
                          }
                        });
                      },
                      mutationName: 'loginLandlord',
                      onComplete: (Map<String, dynamic>? result) {
                        loadingDialog.close(context);
                        if (result == null) {
                          return;
                        }
                        Landlord landlord = Landlord.fromJson(result);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage(
                                  email: landlord.email,
                                  password: landlord.password)),
                        );
                      },
                    ),
                  )
                ],
              )),
        ),
      )),
    );
  }
}
