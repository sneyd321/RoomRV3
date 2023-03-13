import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class DeleteLandlordDialog extends StatelessWidget {
  final Landlord landlord;
  const DeleteLandlordDialog({Key? key, required this.landlord})
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
              backgroundColor: Colors.red,
              child: Icon(
                Icons.warning,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                "This will delete your account but but not your properties.\nThis means tenants will still have access to your properties but you will not.\nDo you still want to delete your account?",
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
        builder: (runMutation) {
          return createAlertDialog(
              context,
              () =>
                  runMutation({"landlord": landlord.toLandlordProfileInput()}));
        },
        mutationName: 'deleteLandlord',
        onComplete: (json) {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}
