import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../../FormFields/SuggestedFormField.dart';
import '../../buttons/CallToActionButton.dart';
import '../../buttons/SecondaryActionButton.dart';

class UpdateTenantEmailForm extends StatefulWidget {
  final Function(BuildContext context, String email) onSave;
  final String firstName;
  final String lastName;
  final String houseKey;
  final List<String> names;

  const UpdateTenantEmailForm(
      {Key? key,
      required this.onSave,
      required this.names,
      required this.firstName,
      required this.lastName,
      required this.houseKey})
      : super(key: key);

  @override
  State<UpdateTenantEmailForm> createState() => _UpdateTenantEmailFormState();
}

class _UpdateTenantEmailFormState extends State<UpdateTenantEmailForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = "";

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: MutationHelper(
        builder: (runMutation) {
          return Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: SuggestedFormField(
                        textEditingController: TextEditingController(),
                        label: "Email",
                        icon: Icons.label,
                        onSaved: (String? value) {
                          email = value!;
                        },
                        onValidate: (String? value) {
                          return Email(value!).validate();
                        },
                        suggestedNames: widget.names),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: CallToActionButton(
                        text: "Add",
                        onClick: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            runMutation({
                              "houseKey": widget.houseKey,
                              "tenant": {
                                "firstName": widget.firstName,
                                "lastName": widget.lastName,
                                "email": email
                              }
                            });
                            widget.onSave(context, email);
                          }
                        }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: SecondaryActionButton(
                        text: "Back",
                        onClick: () {
                          Navigator.pop(context);
                        }),
                  ),
                ]),
          );
        },
        mutationName: 'addTenant',
        onComplete: (json) {},
      ),
    );
  }
}
