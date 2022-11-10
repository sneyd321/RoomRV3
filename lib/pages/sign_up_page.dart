import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/pages/login_page.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Dialogs/loading_dialog.dart';
import 'package:notification_app/widgets/FormFields/EmailFormField.dart';
import 'package:notification_app/widgets/FormFields/PasswordFormField.dart';
import 'package:notification_app/widgets/FormFields/SimpleFormField.dart';

import '../graphql/mutation_helper.dart';
import '../widgets/Forms/FormRow/TwoColumnRow.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Landlord landlord = Landlord();
  String password = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoadingDialog loadingDialog = LoadingDialog();

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
                    TwoColumnRow(
                        left: SimpleFormField(
                            label: "First Name",
                            icon: Icons.account_circle,
                            textEditingController: TextEditingController(),
                            onSaved: (value) {
                              landlord.setFirstName(value!);
                            },
                            onValidate: (value) {
                              return FirstName(value!).validate();
                            }),
                        right: SimpleFormField(
                            label: "Last Name",
                            icon: Icons.account_circle,
                            textEditingController: TextEditingController(),
                            onSaved: (value) {
                              landlord.setLastName(value!);
                            },
                            onValidate: (value) {
                              return LastName(value!).validate();
                            })),
                    EmailFormField(
                      textEditingController: TextEditingController(),
                      onSaved: (value) {
                        landlord.setEmail(value);
                      },
                    ),
                    PasswordFormField(
                        label: "Password",
                        icon: Icons.password,
                        textEditingController: TextEditingController(),
                        onSaved: (value) {},
                        onValidate: (value) {
                          password = value!;
                          return Password(value).validate();
                        }),
                    PasswordFormField(
                        label: "Re Type Password",
                        icon: Icons.password,
                        textEditingController: TextEditingController(),
                        onSaved: (value) {
                          landlord.setPassword(value!);
                        },
                        onValidate: (value) {
                          return ReTypePassword(value!)
                              .validatePassword(password);
                        }),
                    PrimaryButton(Icons.account_box_sharp, "Create Account",
                        (context) {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        runMutation({"landlord": landlord.toJson()});
                        loadingDialog.show(context);
                      }
                    })
                    /*
                    MutationButton(
                      mutationName: 'createLandlord',
                      onComplete: (Map<String, dynamic>? result) {
                        loadingDialog.close(context);
                        if (result == null) {
                          return;
                        }
                       
                      },
                      builder: (runMutation, result) {
                        return PrimaryButton(Icons.account_box, "Sign Up",
                            (context) {
                          
                        });
                      },
                    )
                    */
                  ],
                ),
              ),
            ),
          );
        },
        mutationName: 'createLandlord',
        onComplete: (json) {
          Landlord landlord = Landlord.fromJson(json);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(
                    email: landlord.email, password: landlord.password)),
          );
        },
      )),
    );
  }
}
