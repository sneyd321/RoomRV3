import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/list_items/deposit.dart';
import 'package:notification_app/business_logic/list_items/detail.dart';
import 'package:notification_app/widgets/Helper/TextHelper.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/DetailsList.dart';

class DepositCard extends StatelessWidget {
  final Deposit deposit;
  final Function(BuildContext context, Deposit deposit)  onItemRemoved;
  const DepositCard({Key? key, required this.deposit, required this.onItemRemoved, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(title: TextHelper(text: deposit.name), trailing: IconButton(icon: Icon(Icons.close), onPressed: () {
            onItemRemoved(context, deposit);
          },),),
          ListTile(
            title: TextHelper(text: "Amount: \$${deposit.getAmount()}"),
          ),
          DetailsList(
            details: deposit.details.map<String>((Detail detail) => detail.detail).toList(),
          )
        ],
      ),
    );
  }
}
