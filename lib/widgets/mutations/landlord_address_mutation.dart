import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/landlord_info.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

class UpdateLandlordInfoMutation extends StatefulWidget {
  final Lease lease;
  final GlobalKey<FormState> formKey;
  final Function(BuildContext context, LandlordAddress landlordAddress)
      onComplete;
  const UpdateLandlordInfoMutation(
      {Key? key,
      required this.onComplete,
      required this.formKey,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateLandlordInfoMutation> createState() =>
      _UpdateLandlordInfoMutationState();
}

class _UpdateLandlordInfoMutationState
    extends State<UpdateLandlordInfoMutation> {
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

  AlertDialog failedMessage = AlertDialog(
    content: Row(
      children: const [
        Icon(Icons.close),
        Text("Failed to connect to server."),
      ],
    ),
  );

  dynamic getMutation() {
    return gql(r"""
  mutation updateLandlordAddress($id: ID!, $landlordAddress: LandlordAddressInput!){
    updateLandlordAddress(id: $id, inputData: $landlordAddress) {
streetNumber,
  streetName,
  city,
  province,
  postalCode,
  unitNumber,
  poBox
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
          print(resultData!);
          widget.onComplete(context,
              LandlordAddress.fromJson(resultData["updateLandlordAddress"]));
        },
      ),
      builder: (runMutation, result) {
        return SecondaryButton(
          Icons.update,
          "Update",
          (context) {
            if (widget.formKey.currentState!.validate()) {
              widget.formKey.currentState!.save();
              runMutation({
                "id": widget.lease.leaseId,
                "landlordAddress": widget.lease.landlordAddress.toJson()
              });

              Timer timer = Timer(const Duration(milliseconds: 20000), () {
                Navigator.of(context, rootNavigator: true).pop();
              });
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              ).then((value) {
                timer.cancel();
                showDialog(
                    context: context,
                    builder: (context) {
                      return failedMessage;
                    });
              });
            }
          },
        );
      },
    );
  }
}
