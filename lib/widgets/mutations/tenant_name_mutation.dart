import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/business_logic/list_items/tenant_name.dart';
import 'package:notification_app/business_logic/list_items/utility.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

class UpdateTenantNameMutation extends StatefulWidget {
  final Lease lease;
  final bool Function() validate;
  final Function(BuildContext context, List<TenantName> tenantNames) onComplete;

  const UpdateTenantNameMutation(
      {Key? key, required this.lease, required this.onComplete, required this.validate})
      : super(key: key);

  @override
  State<UpdateTenantNameMutation> createState() => _UpdateTenantNameMutationState();
}

class _UpdateTenantNameMutationState extends State<UpdateTenantNameMutation> {
  String errorText = "";
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );

 

  dynamic getMutation() {
    return gql(r"""
  mutation updateTenantNames($id: ID!, $tenantNames: [TenantNameInput!]!){
     updateTenantNames(id: $id, inputData: $tenantNames) {
    name
   
  }
  }
  """);
  }

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: getMutation(),
        onCompleted: (Map<String, dynamic>? resultData) async {
          Navigator.pop(context);
          List<TenantName> tenantNames = resultData!["updateTenantNames"]
              .map<TenantName>(
                  (serviceJson) => TenantName.fromJson(serviceJson))
              .toList();
          widget.onComplete(context, tenantNames);
        },
      ),
      builder: (runMutation, result) {
        return 
            
             SecondaryButton(
              Icons.update,
              "Update",
              (context) {
                if (widget.validate()) {
                  runMutation({
                    "id": widget.lease.leaseId,
                    "tenantNames": widget.lease.tenantNames
                        .map((tenantName) => tenantName.toJson())
                        .toList()
                  });
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
              },
         
         
        );
      },
    );
  }
}
