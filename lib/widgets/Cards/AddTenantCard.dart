import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/tenant.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';


class AddTenantCard extends StatelessWidget {
  final Tenant tenant;
  final String houseKey;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddTenantCard({Key? key, required this.tenant, required this.houseKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: const CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 95,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 16),
                child: Center(
                    child: Text(
                  tenant.getFullName(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ))),
            Container(
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                child: Center(
                    child: Text(
                  tenant.email,
                ))),
     
            SecondaryButton(Icons.email, "Invite", (context) {
              showDialog(
                context: context, 
                builder: (context) {
                  return GraphQLProvider(
                      client: GQLClient().getClient(),
                      child: MutationHelper(onComplete: (json) {
                        Navigator.pop(context);
                      }, 
                      mutationName: "addTenantEmail", builder: ((runMutation) {
                        return AlertDialog(
                          actions: [
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                
                                runMutation({
                                  "houseKey": houseKey,
                                  "tenant": tenant.toJson()
                                });
                               
                              },
                            ),
                          ],
                          content:  Row(
                          
                            children: const [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text("This will send an email to this tenant with:\n- A copy of the lease agreement\n- The house key\n- Access to the tenant version of the app.\n\nFor the tenant to get access you will need to approve the tenant in the notification feed after the tenant signs the lease agreement.\n\nWould you like to continue?",
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ));
                      })),
                    );
                  
                });
            })
          ],
        ),
    );
  }
}
