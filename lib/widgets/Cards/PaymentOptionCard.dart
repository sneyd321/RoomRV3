import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class PaymentOptionCard extends StatelessWidget {
  final PaymentOption paymentOption;
  final Function(BuildContext context, PaymentOption paymentOption) onItemRemoved;
  const PaymentOptionCard({Key? key, required this.paymentOption, required this.onItemRemoved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.payment),
        title: Text(paymentOption.name),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            onItemRemoved(context, paymentOption);
          },
        ),
      ),
    );
  }
}
