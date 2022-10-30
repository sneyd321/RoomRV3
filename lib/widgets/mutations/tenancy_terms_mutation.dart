import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/landlord_info.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

class UpdateTenancyTermsMutation extends StatefulWidget {
  final Lease lease;
  final GlobalKey<FormState> formKey;
  const UpdateTenancyTermsMutation(
      {Key? key,
      required this.formKey,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateTenancyTermsMutation> createState() =>
      _UpdateTenancyTermsMutationState();
}

class _UpdateTenancyTermsMutationState
    extends State<UpdateTenancyTermsMutation> {
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
  mutation updateTenancyTerms($id: ID!, $tenancyTerms: TenancyTermsInput!){
    updateTenancyTerms(id: $id, inputData: $tenancyTerms ) {
  rentalPeriod {
    rentalPeriod,
    endDate
  },
  startDate,
  rentDueDate,
  paymentPeriod, 
  partialPeriod {
    amount,
    dueDate,
    startDate,
    endDate,
    isEnabled
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
                "tenancyTerms": widget.lease.tenancyTerms.toJson()
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
