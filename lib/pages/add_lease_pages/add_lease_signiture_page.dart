import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';
import 'package:signature/signature.dart';

import '../../graphql/mutation_helper.dart';
import '../../widgets/buttons/PrimaryButton.dart';
import '../../widgets/buttons/SecondaryButton.dart';

class AddLeaseSigniturePage extends StatefulWidget {
  final Function(BuildContext context) onBack;
  final Lease lease;
  final Landlord landlord;
  const AddLeaseSigniturePage({
    Key? key,
    required this.onBack,
    required this.lease, required this.landlord,
  }) : super(key: key);

  @override
  State<AddLeaseSigniturePage> createState() => _AddLeaseSigniturePageState();
}

class _AddLeaseSigniturePageState extends State<AddLeaseSigniturePage> {
  final SignatureController controller =
      SignatureController(exportBackgroundColor: Colors.white);
  String signitureError = "";
  void onBack(BuildContext context) {
    widget.onBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: MutationHelper(
        builder: (runMutation) {
          return Scaffold(
              body: Column(
            children: [
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(8),
                child: ClipRRect(
                  child: SizedBox(
                    height: 125,
                    child: Signature(
                      controller: controller,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(signitureError,
                        style: const TextStyle(color: Colors.red))),
              ),
              SecondaryButton(Icons.clear_outlined, "Clear", (context) {
                controller.clear();
              }),
              const Spacer(),
              TwoColumnRow(
                  left: SecondaryButton(Icons.chevron_left, "Back", onBack),
                  right: PrimaryButton(Icons.upload, "Create Lease",
                      (context) async {
                    String base64EncodedSigniture =
                        base64Encode(await controller.toPngBytes() ?? []);
                    runMutation({
                      "landlordId": widget.landlord.id,
                      "lease": widget.lease.toJson(),
                      "signature": base64EncodedSigniture
                    });
                  }))
            ],
          ));
        },
        mutationName: 'createHouse',
        onComplete: (json) {},
      ),
    );
  }
}
