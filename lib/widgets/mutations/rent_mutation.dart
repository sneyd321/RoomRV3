import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/landlord_info.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/rent.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

class UpdateRentMutation extends StatefulWidget {
  final Lease lease;
  final GlobalKey<FormState> formKey;
  const UpdateRentMutation(
      {Key? key,
      required this.formKey,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateRentMutation> createState() =>
      _UpdateRentMutationState();
}

class _UpdateRentMutationState
    extends State<UpdateRentMutation> {
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
  mutation updateRent($id: ID!, $rent: RentInput!){
    updateRent(id: $id, inputData: $rent) {
  baseRent,
  rentMadePayableTo,
  rentServices {
    name,
    amount
  },
  paymentOptions {
    name
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
                "rent": widget.lease.rent.toJson()
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
