import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/landlord_info.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

class UpdateRentalAddressMutation extends StatefulWidget {
  final Lease lease;
  final GlobalKey<FormState> formKey;
  final Function(BuildContext context, RentalAddress rentalAddress) onComplete;
  const UpdateRentalAddressMutation(
      {Key? key,
      required this.onComplete,
      required this.formKey,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateRentalAddressMutation> createState() =>
      _UpdateRentalAddressMutationState();
}

class _UpdateRentalAddressMutationState
    extends State<UpdateRentalAddressMutation> {
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
  mutation updateRentalAddress($id: ID!, $rentalAddress: RentalAddressInput!){
    updateRentalAddress(id: $id, inputData: $rentalAddress) {
streetNumber  ,
  streetName,
  city,
  province,
  postalCode,
	unitName,
  isCondo,
  parkingDescriptions {
    description
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
              RentalAddress.fromJson(resultData!["updateRentalAddress"]));
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
                "rentalAddress": widget.lease.rentalAddress.toJson()
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
