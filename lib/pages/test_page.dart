import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/maintenance_ticket.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Dialogs/loading_dialog.dart';

import '../graphql/mutation_helper.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GQLClient().getClient(),
        child: MutationHelper(
            mutationName: 'createMaintenanceTicket',
            onComplete: (json) {

            },
            builder: (runMutation) {
              return SafeArea(
                    child: Scaffold(
                  appBar: AppBar(
                    title: const Text("Documents"),
                  ),
                  body: Column(children: [
                    Spacer(),
                    PrimaryButton(Icons.abc, "TEST", (context) {
                      runMutation({
                        "houseKey": "RHY0TA",
                        "maintenanceTicket": MaintenanceTicket().toJson(),
                        "image": "sadf"
                      });
                        
                    })
                  ]),
                ),
              );
            }));
  }
}
