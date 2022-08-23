import 'package:flutter/cupertino.dart';
import 'package:notification_app/widgets/Cards/PaymentOptionCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';

import '../../../business_logic/list_items/payment_option.dart';

class PaymentOptionsList extends StatefulWidget {
  final List<PaymentOption> paymentOptions;
  const PaymentOptionsList({Key? key, required this.paymentOptions}) : super(key: key);

  @override
  State<PaymentOptionsList> createState() => _PaymentOptionsListState();
}

class _PaymentOptionsListState extends State<PaymentOptionsList> {
  @override
  Widget build(BuildContext context) {
    return SliverAddItemGeneratorWrapper(
      shirnkWrap: true,
      items: widget.paymentOptions, generator: (index) {
      PaymentOption paymentOption = widget.paymentOptions[index];
      return PaymentOptionCard(paymentOption: paymentOption, onItemRemoved: (context, paymentOption) {
        setState(() {
          widget.paymentOptions.remove(paymentOption);
        });
      });
    }, form: AddNameForm(names: [], onSave: (BuildContext context, name) { 
      setState(() {
        widget.paymentOptions.add(CustomPaymentOption(name));
      });
     }, ));
  }
}