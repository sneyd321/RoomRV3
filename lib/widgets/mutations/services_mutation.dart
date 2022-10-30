import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

class UpdateServicesMutation extends StatefulWidget {
  final Lease lease;
  final bool Function() validate;
  final Function(BuildContext context, List<Service> services) onComplete;

  const UpdateServicesMutation(
      {Key? key, required this.lease, required this.onComplete, required this.validate})
      : super(key: key);

  @override
  State<UpdateServicesMutation> createState() => _UpdateServicesMutationState();
}

class _UpdateServicesMutationState extends State<UpdateServicesMutation> {
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
  mutation updateServices($id: ID!, $services: [ServiceInput!]!){
    updateServices(id: $id, inputData: $services) {
    name,
    isIncludedInRent,
    isPayPerUse,
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
          List<Service> services = resultData!["updateServices"]
              .map<PayPerUseService>(
                  (serviceJson) => CustomService.fromJson(serviceJson))
              .toList();
          widget.onComplete(context, services);
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
                    "services": widget.lease.services
                        .map((service) => service.toJson())
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
