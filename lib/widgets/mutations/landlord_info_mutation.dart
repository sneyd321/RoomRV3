import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord_info.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

class UpdateLandlordAddressMutation extends StatefulWidget {
  final Lease lease;
  final GlobalKey<FormState> formKey;
  final Function(BuildContext context, LandlordInfo landlordInfo) onComplete;
  const UpdateLandlordAddressMutation(
      {Key? key,
      required this.onComplete,
      required this.formKey,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateLandlordAddressMutation> createState() =>
      _UpdateLandlordAddressMutationState();
}

class _UpdateLandlordAddressMutationState
    extends State<UpdateLandlordAddressMutation> {
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
  mutation updateLandlordInfo($id: ID!, $landlordInfo: LandlordInfoInput!){
    updateLandlordInfo(id: $id, inputData: $landlordInfo){
      fullName,
      receiveDocumentsByEmail,
      emails {
        email
      },
      contactInfo,
      contacts {
        contact
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

          widget.onComplete(context,
              LandlordInfo.fromJson(resultData!["updateLandlordInfo"]));
        },
      ),
      builder: (runMutation, result) {
        return  SecondaryButton(
              Icons.update,
              "Update",
          (context) {
            if (widget.formKey.currentState!.validate()) {
              widget.formKey.currentState!.save();
              runMutation({
                "id": widget.lease.leaseId,
                "landlordInfo": widget.lease.landlordInfo.toJson()
              });
            }
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
