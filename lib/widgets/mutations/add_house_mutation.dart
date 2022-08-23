import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/services/mutation_factory.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';

class AddHouseMutation extends StatefulWidget {
  final House house;
  final Function(BuildContext context, int houseId)
      onComplete;
  const AddHouseMutation(
      {Key? key, required this.onComplete, required this.house})
      : super(key: key);

  @override
  State<AddHouseMutation> createState() => _AddHouseMutationState();
}

class _AddHouseMutationState extends State<AddHouseMutation> {
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

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: MutationFactory().getDocument("Add House"),
        onCompleted: (Map<String, dynamic>? resultData) async {
          Navigator.pop(context);
          widget.onComplete(context, resultData!["createHouse"]["id"]);
        },
      ),
      builder: (runMutation, result) {
        return PrimaryButton(
          Icons.upload,
          "Upload",
          (context) {
            runMutation({'houseInput': widget.house.toJson()});
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
