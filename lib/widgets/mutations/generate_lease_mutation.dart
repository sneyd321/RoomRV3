import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';

class GenerateLeaseMutation extends StatefulWidget {
  final Lease lease;
  final int houseId;
  final String firebaseId;
  final Function(BuildContext context, int houseId) onComplete;
  const GenerateLeaseMutation(
      {Key? key,
      required this.onComplete,
      required this.lease,
      required this.houseId,
      required this.firebaseId})
      : super(key: key);

  @override
  State<GenerateLeaseMutation> createState() => _GenerateLeaseMutationState();
}

class _GenerateLeaseMutationState extends State<GenerateLeaseMutation> {
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
  mutation scheduleLease($id: Int!, $firebaseId: String!){
   scheduleLease(houseId: $id, firebaseId: $firebaseId){
    firebaseId
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
          widget.onComplete(context, 0);
        },
      ),
      builder: (runMutation, result) {
        return PrimaryButton(
          Icons.assignment,
          "Create",
          (context) async {
            runMutation({
              "id": widget.houseId,
              "firebaseId": widget.firebaseId
            });
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          },
        );
      },
    );
  }
}
