import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/additional_term.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

class UpdateAdditionalTermsMutation extends StatefulWidget {
  final Lease lease;
  final bool Function() validate;
  final Function(BuildContext context, List<AdditionalTerm> additionalTerm) onComplete;

  const UpdateAdditionalTermsMutation(
      {Key? key, required this.lease, required this.onComplete, required this.validate})
      : super(key: key);

  @override
  State<UpdateAdditionalTermsMutation> createState() => _UpdateAdditionalTermsMutationState();
}

class _UpdateAdditionalTermsMutationState extends State<UpdateAdditionalTermsMutation> {
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
  mutation updateAdditionalTerms($id: ID!, $additionalTerms: [AdditionalTermInput!]!){
    updateAdditionalTerms(id: $id, inputData: $additionalTerms) {
    name,
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
          List<AdditionalTerm> additionalTerms = resultData!["updateAdditionalTerms"]
              .map<AdditionalTerm>(
                  (serviceJson) => CustomTerm.fromJson(serviceJson))
              .toList();
          widget.onComplete(context, additionalTerms);
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
                    "additionalTerms": widget.lease.additionalTerms
                        .map((additionalTerm) => additionalTerm.toJson())
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
