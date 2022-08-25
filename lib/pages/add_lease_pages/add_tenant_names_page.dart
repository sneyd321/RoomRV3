import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/TenantNamesList.dart';
import 'package:notification_app/widgets/mutations/add_house_mutation.dart';

class AddTenantNamesPage extends StatefulWidget {
  final Lease lease;

  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddTenantNamesPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddTenantNamesPage> createState() => _AddTenantNamesPageState();
}

class _AddTenantNamesPageState extends State<AddTenantNamesPage> {
  String errorText = "";
  GQLClient gqlClient = GQLClient();
  
  void onNextCallback(BuildContext context) {
   
    widget.onNext(context);
    
  }

  void onBackCallback(BuildContext context) {
    widget.onBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: gqlClient.getClient(),
      child: Column(
        children: [
          Expanded(child: TenantNamesList(tenantNames: widget.lease.tenantNames)),
          Container(
            margin: const EdgeInsets.only(left: 8, bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 18),)),
           TwoColumnRow(
              left: SecondaryButton(Icons.chevron_left, "Back", onBackCallback),
              right: AddHouseMutation(onComplete: ((context, houseId) {
                onNextCallback(context);
              }), lease: widget.lease))
        ],
      ),
    );
  }
}


