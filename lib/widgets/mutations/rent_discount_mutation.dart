import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/rent_discount.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/business_logic/list_items/utility.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

class UpdateRentDiscountMutation extends StatefulWidget {
  final Lease lease;
  final bool Function() validate;
  final Function(BuildContext context, List<RentDiscount> discounts) onComplete;

  const UpdateRentDiscountMutation(
      {Key? key, required this.lease, required this.onComplete, required this.validate})
      : super(key: key);

  @override
  State<UpdateRentDiscountMutation> createState() => _UpdateRentDiscountMutationState();
}

class _UpdateRentDiscountMutationState extends State<UpdateRentDiscountMutation> {
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
  mutation updateRentDiscount($id: ID!, $rentDiscounts: [RentDiscountInput!]!){
     updateRentDiscounts(id: $id, inputData: $rentDiscounts) {
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
          List<RentDiscount> rentDiscounts = resultData!["updateRentDiscounts"]
              .map<RentDiscount>(
                  (serviceJson) => CustomRentDiscount.fromJson(serviceJson))
              .toList();
          widget.onComplete(context, rentDiscounts);
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
                    "rentDiscounts": widget.lease.rentDiscounts
                        .map((rentDiscount) => rentDiscount.toJson())
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
