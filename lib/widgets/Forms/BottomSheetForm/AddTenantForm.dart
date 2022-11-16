import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/tenant.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';

import '../../../business_logic/fields/field.dart';
import '../../../graphql/mutation_helper.dart';
import '../../../services/graphql_client.dart';
import '../../Buttons/SecondaryButton.dart';
import '../../FormFields/SimpleFormField.dart';
import '../FormRow/TwoColumnRow.dart';

class AddTenantEmailForm extends StatefulWidget {
  final int houseId;
  const AddTenantEmailForm({Key? key, required this.houseId})
      : super(key: key);

  @override
  State<AddTenantEmailForm> createState() => _AddTenantEmailFormState();
}

class _AddTenantEmailFormState extends State<AddTenantEmailForm> {
  Tenant tenant = Tenant();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: MutationHelper(
          mutationName: "createTempTenant",
          onComplete: (json) {
            Tenant tenant = Tenant.fromJson(json);
            Navigator.pop(context, tenant);
          },
          builder: (runMutation) {
            return Form(
                key: formKey,
                child: Column(
                  children: [
                    SimpleFormField(label: "First and Last Name", icon: Icons.account_circle, textEditingController: TextEditingController(), onSaved: (value) {
                      List<String> fullName = value!.split(" ");
                      if (fullName.length > 1) {
                        tenant.firstName = fullName[0];
                        tenant.lastName = fullName[1];
                      }
                      else {
                        tenant.firstName = value;
                      }
                    }, field: Name(""),),
                    SimpleFormField(label: "Email", icon: Icons.email, textEditingController: TextEditingController(), onSaved: (value) {
                      tenant.email = value!;
                    },field: Email(""),),
                    TwoColumnRow(
                        left: SecondaryButton(Icons.arrow_downward, "Back",
                            (context) {
                          Navigator.pop(context);
                        }),
                        right: PrimaryButton(Icons.add, "Add", ((context) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            runMutation({
                              'houseId': widget.houseId,
                              'tenant': tenant.toJson()
                            });
                            
                          }
                        })))
                  ],
                ));
          }),
    );
  }
}
