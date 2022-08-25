import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';

class AddHouseMutation extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context, int houseId) onComplete;
  const AddHouseMutation(
      {Key? key, required this.onComplete, required this.lease})
      : super(key: key);

  @override
  State<AddHouseMutation> createState() => _AddHouseMutationState();
}

class _AddHouseMutationState extends State<AddHouseMutation> {
  House house = House();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    house.firebaseId = "abc123";
    house.lease = widget.lease;
  }

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

  dynamic getAddHouseMutation() {
    return gql(r"""
  mutation createHouse($id: ID!, $houseInput: HouseInput!){
    createHouse(id: $id, houseInput: $houseInput) {
      id,
      houseKey,
      firebaseId,
      lease{
        landlordInfo{
          fullName
        }
      }
    }
  }
  """);
  }

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: getAddHouseMutation(),
        onCompleted: (Map<String, dynamic>? resultData) async {
          widget.onComplete(context, resultData!["createHouse"]["id"]);
        },
      ),
      builder: (runMutation, result) {
        return PrimaryButton(
          Icons.upload,
          "Upload",
          (context) {
            runMutation({'id': 3, 'houseInput': house.toJson()});
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
