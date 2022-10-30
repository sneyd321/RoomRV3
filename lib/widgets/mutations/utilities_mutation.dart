import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/business_logic/list_items/utility.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

class UpdateUtilitiesMutation extends StatefulWidget {
  final Lease lease;
  final bool Function() validate;
  final Function(BuildContext context, List<Utility> utilities) onComplete;

  const UpdateUtilitiesMutation(
      {Key? key, required this.lease, required this.onComplete, required this.validate})
      : super(key: key);

  @override
  State<UpdateUtilitiesMutation> createState() => _UpdateUtilitiesMutationState();
}

class _UpdateUtilitiesMutationState extends State<UpdateUtilitiesMutation> {
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
  mutation updateUtilities($id: ID!, $utilities: [UtilityInput!]!){
    updateUtilities(id: $id, inputData: $utilities) {
    name,
    responsibility
    details{
      detail
    }
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
          List<Utility> utilities= resultData!["updateUtilities"]
              .map<Utility>(
                  (serviceJson) => CustomUtility.fromJson(serviceJson))
              .toList();
          widget.onComplete(context, utilities);
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
                    "utilities": widget.lease.utilities
                        .map((utility) => utility.toJson())
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
