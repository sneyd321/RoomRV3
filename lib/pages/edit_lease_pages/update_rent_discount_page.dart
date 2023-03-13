import 'package:flutter/material.dart';
import 'package:notification_app/bloc/helper/SecondaryActionButton.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class UpdateRentDiscountPage extends StatefulWidget {
  final Lease lease;

  const UpdateRentDiscountPage({Key? key, required this.lease})
      : super(key: key);

  @override
  State<UpdateRentDiscountPage> createState() => _UpdateRentDiscountPageState();
}

class _UpdateRentDiscountPageState extends State<UpdateRentDiscountPage> {
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return MutationHelper(
        mutationName: "updateRentDiscounts",
        onComplete: (json) {},
        builder: (runMutation) {
          return Column(
            children: [
             
              Container(
                  margin: const EdgeInsets.only(left: 8, bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    errorText,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  )),
              Container(
                margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: SecondaryActionButton(
                    text: "Update Rent Discounts",
                    onClick: () {
                      runMutation({
                        "houseId": widget.lease.houseId,
                        "rentDiscounts": widget.lease.rentDiscounts
                            .map((rentDiscount) =>
                                rentDiscount.toRentDiscountInput())
                            .toList()
                      });
                    }),
              )
            ],
          );
        });
  }
}
