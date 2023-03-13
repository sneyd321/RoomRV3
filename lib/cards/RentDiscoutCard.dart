import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class RentDiscountCard extends StatelessWidget{
  final RentDiscount rentDiscount;
  final Function(BuildContext context, RentDiscount rentDiscount) onItemRemoved;
  const RentDiscountCard({Key? key, required this.rentDiscount, required this.onItemRemoved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.discount),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               Expanded(
                 flex: 2,
                 child: Text(rentDiscount.name)),
               const Spacer(),
                 Text(rentDiscount.amount),
              ],
            ),
            trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            onItemRemoved(context, rentDiscount);
          },
        )
          ),
        ],
      ),
    );
  }


 
}
