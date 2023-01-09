import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/widgets/buttons/SecondaryActionButton.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../buttons/CallToActionButton.dart';
import '../buttons/ProfilePicture.dart';

class AddTenantCard extends StatefulWidget {
  final Tenant tenant;
  final String houseKey;
  final void Function() onDeleteTenant;
  final bool isDeleteVisible;
  const AddTenantCard(
      {Key? key,
      required this.tenant,
      required this.houseKey,
      required this.onDeleteTenant,
      this.isDeleteVisible = true})
      : super(key: key);

  @override
  State<AddTenantCard> createState() => _AddTenantCardState();
}

class _AddTenantCardState extends State<AddTenantCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void showInviteDialog() {
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
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () {
                              runMutation({
                                "houseKey": widget.houseKey,
                                "tenant": widget.tenant.toAddEmailInput()
                              });
                            },
                          ),
                        ],
                        content: Row(
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
                              child: Text(
                                "This will send an email to this tenant with:\n- A copy of the lease agreement\n- The house key\n- Access to the tenant version of the app.\n\nWould you like to continue?",
                                softWrap: true,
                              ),
                            ),
                          ],
                        ));
                  })));
        });
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: MutationHelper(
          mutationName: 'deleteTenant',
          onComplete: (json) {
            widget.onDeleteTenant();
          },
          builder: (runMutation) {
            return Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfilePicture(
                        icon: Icons.account_circle,
                        profileSize: 80,
                        iconSize: 150,
                        text: widget.tenant.getFullName(),
                        profileURL: widget.tenant.profileURL,
                        onClick: () {}),
                    Visibility(
                      visible: widget.isDeleteVisible,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(20)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(Colors.red),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(45),
                                        side: const BorderSide(
                                            color: Colors.red)))),
                            onPressed: () async {
                              runMutation(
                                  {"tenant": widget.tenant.toTenantInput()});
                            },
                            child: const Text(
                              "Remove Tenant",
                            )),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.tenant.getFullName(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                    Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.tenant.email,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      child: CallToActionButton(text: "Invite", onClick: () {
                        showInviteDialog();
                      }),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                      child: SecondaryActionButton(
                          text: "Go Back",
                          onClick: () {
                            Navigator.of(context).pop();
                          }),
                    )
                  ]),
            );
          }),
    );
  }
}
