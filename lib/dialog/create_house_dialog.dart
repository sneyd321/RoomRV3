import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class CreateHouseDialog extends StatelessWidget {
  final Landlord landlord;
  final Lease lease;
  const CreateHouseDialog(
      {Key? key, required this.landlord, required this.lease})
      : super(key: key);

  Widget createAlertDialog(BuildContext context, Function() onYes) {
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
              onYes();
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
                "This action will:\n1. Create a lease agreement available for download and your signature in the notification feed (Please give some time for it to generate).\n2. Create a house key to invite tenants to your property.\n3.Provide the ability to edit the lease\n\nFor security purposes you will be required to log back in.\n\nWould you like to continue?",
                softWrap: true,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GQLClient().getClient(),
        child: MutationHelper(
            mutationName: 'createHouse',
            onComplete: (json) {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            builder: ((runMutation) {
              return createAlertDialog(
                  context,
                  () => runMutation({
                        "landlord": landlord.toLandlordInput(""),
                        "lease": lease.toLeaseInput()
                      }));
            })));
  }
}
