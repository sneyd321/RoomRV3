import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/RentDiscountsList.dart';

import '../../business_logic/house.dart';

class UpdateRentDiscountPage extends StatefulWidget {
  final House house;

  const UpdateRentDiscountPage(
      {Key? key,
      required this.house})
      : super(key: key);

  @override
  State<UpdateRentDiscountPage> createState() => _UpdateRentDiscountPageState();
}

class _UpdateRentDiscountPageState extends State<UpdateRentDiscountPage> {
  String errorText = "";
  bool validate() {
      return true;
  }


  @override
  Widget build(BuildContext context) {
    return MutationHelper(
      mutationName: "updateRentDiscounts",
      onComplete: (json) {
        
      },
      builder: (runMutation) {
        return Column(
          children: [
            Expanded(child: RentDiscountsList(rentDiscounts: widget.house.lease.rentDiscounts)),
            Container(
              margin: const EdgeInsets.only(left: 8, bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 18),)),
             SecondaryButton(Icons.update, "Update Rent Discounts", (context) {
                if (validate()) {
                  runMutation({
                    "houseId": widget.house.houseId,
                    "rentDiscounts": widget.house.lease.rentDiscounts
                        .map((rentDiscount) => rentDiscount.toJson())
                        .toList()
                  });
                }
             })
          ],
        );
      }
    );
  }
}


