import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/business_logic/tenant.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/FormFields/SimpleFormField.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';
import 'package:notification_app/widgets/Helper/BottomSheetHelper.dart';
import 'package:notification_app/widgets/Helper/TextHelper.dart';
import 'package:notification_app/widgets/mutations/add_tenant_email_mutation.dart';

import '../../services/graphql_client.dart';

class AddTenantCard extends StatelessWidget {
  final Tenant tenant;
  final String houseKey;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddTenantCard({Key? key, required this.tenant, required this.houseKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(left: 8, right: 8),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: const Icon(Icons.account_circle, color: Colors.blue, size: 35),
        ),
        TextHelper(text: tenant.getFullName()),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(
                  Icons.email,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () {
                  BottomSheetHelper(GraphQLProvider(
                    client: GQLClient().getClient(),
                    child: Form(
                      key: formKey,
                        child: Column(
                      children: [
                        SimpleFormField(
                            label: "Email",
                            icon: Icons.email,
                            textEditingController: TextEditingController(),
                            onSaved: (value) {
                              tenant.setEmail(value!);
                            },
                            onValidate: (value) {
                              return Email(value!).validate();
                            }),
                        TwoColumnRow(
                            left: SecondaryButton(Icons.chevron_left, "Back",
                                (context) {
                              Navigator.pop(context);
                            }),
                            right: AddTenantMutation(
                              formKey: formKey,
                              houseKey: houseKey,
                              tenant: tenant,
                              onComplete:
                                  (BuildContext context, int houseId) {},
                            ))
                      ],
                    )),
                  )).show(context);
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.only(right: 8),
                child: const Text("Invite"))
          ],
        )
      ]),
    );
  }
}
