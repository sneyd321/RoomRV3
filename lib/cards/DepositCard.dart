import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

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
          ListTile(title: Text(deposit.name), trailing: IconButton(icon: Icon(Icons.close), onPressed: () {
            onItemRemoved(context, deposit);
          },),),
          ListTile(
            title: Text("Amount: \$${deposit.amount}"),
          ),
        ],
      ),
    );
  }
}
