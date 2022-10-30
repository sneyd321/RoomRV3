import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/deposit.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

class UpdateDepositMutation extends StatefulWidget {
  final Lease lease;
  final bool Function() validate;
  final Function(BuildContext context, List<Deposit> deposits) onComplete;

  const UpdateDepositMutation(
      {Key? key, required this.lease, required this.onComplete, required this.validate})
      : super(key: key);

  @override
  State<UpdateDepositMutation> createState() => _UpdateDepositMutationState();
}

class _UpdateDepositMutationState extends State<UpdateDepositMutation> {
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
   mutation updateDeposit($id: ID!, $rentDeposit: [RentDepositInput!]!){
     updateRentDeposit(id: $id, inputData: $rentDeposit) {
    name,
    amount,
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
          List<Deposit> rentDeposits = resultData!["updateRentDeposits"]
              .map<Deposit>(
                  (serviceJson) => CustomDeposit.fromJson(serviceJson))
              .toList();
          widget.onComplete(context, rentDeposits);
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
                    "rentDeposit": widget.lease.rentDeposits
                        .map((rentDeposit) => rentDeposit.toJson())
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
