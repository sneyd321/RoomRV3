import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/tenant.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

import '../Forms/FormRow/TwoColumnRow.dart';

class AddTenantCard extends StatelessWidget {
  final Tenant tenant;
  final String houseKey;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final void Function(Tenant tenant) onDeleteTenant;
  AddTenantCard(
      {Key? key,
      required this.tenant,
      required this.houseKey,
      required this.onDeleteTenant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: MutationHelper(
          mutationName: 'deleteTenant',
          onComplete: (json) {
            onDeleteTenant(Tenant.fromJson(json));
          },
          builder: (runMutation) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: const CircleAvatar(
                      radius: 80.0,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 150,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(20)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45),
                                    side:
                                        const BorderSide(color: Colors.red)))),
                        onPressed: () async {},
                        child: const Text(
                          "Remove Tenant",
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tenant.getFullName(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tenant.email,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Center(
                    child: Row(children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.all(20)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape:
                                        MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(45),
                                                side: const BorderSide(
                                                    color: Colors.black)))),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Go Back",
                                  style: TextStyle(fontSize: 16),
                                )),
                                      
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.all(20)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape:
                                      MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                              side: const BorderSide(
                                                  color: Colors.black)))),
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return GraphQLProvider(
                                          client: GQLClient().getClient(),
                                          child: MutationHelper(
                                              onComplete: (json) {
                                                Navigator.pop(context);
                                              },
                                              mutationName: "addTenant",
                                              builder: ((runMutation) {
                                                return AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                        child: const Text('No'),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child:
                                                            const Text('Yes'),
                                                        onPressed: () {
                                                          runMutation({
                                                            "houseKey":
                                                                houseKey,
                                                            "tenant":
                                                                tenant.toJson()
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                    content: Row(
                                                      children: const [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          child: Icon(
                                                            Icons.error,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            "This will send an email to this tenant with:\n- A copy of the lease agreement\n- The house key\n- Access to the tenant version of the app.\n\nFor the tenant to get access you will need to approve the tenant in the notification feed after the tenant signs the lease agreement.\n\nWould you like to continue?",
                                                            softWrap: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              })));
                                    });
                              },
                              child: const Text(
                                "Invite Tenant",
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                      )
                    ]),
                  )
                ]);
          }),
    );
  }
}
