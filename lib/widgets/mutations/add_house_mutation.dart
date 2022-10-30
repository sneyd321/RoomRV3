import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/services/FirebaseConfig.dart';
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<House> setFirebaseId() async {
    FirebaseConfiguration firebaseConfiguration = FirebaseConfiguration();
    CollectionReference collection = firebaseConfiguration.getDB().collection("House");
    DocumentReference reference = await collection.add({"notifications": []});
    House house = House();
    house.firebaseId = reference.id;
    house.lease = widget.lease;
    return house;
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
          (context) async {
            House house = await setFirebaseId();
            runMutation({'id': 4, 'houseInput': house.toJson()});
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
