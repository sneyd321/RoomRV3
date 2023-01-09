import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Cards/DepositCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameAmountForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemStateWrapper.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class DepositsList extends StatefulWidget {
  final List<Deposit> deposits;
  const DepositsList({Key? key, required this.deposits}) : super(key: key);

  @override
  State<DepositsList> createState() => _DepositsListState();
}

class _DepositsListState extends State<DepositsList> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SliverAddItemStateWrapper(
        items: widget.deposits,
        noItemsText: "No Deposits",
      addButtonTitle: "Add Deposit",
        scrollController: scrollController,
        builder: (context, index) {
          Deposit deposit = widget.deposits[index];
          return DepositCard(
            deposit: deposit,
            onItemRemoved: (context, deposit) {
              setState(() {
                widget.deposits.remove(deposit);
              });
            },
          );
        },
        form: AddNameAmountForm(
            names: [],
            onSave: (context, name, amount) {
              if (widget.deposits.isNotEmpty) {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(seconds: 2),
                  curve: Curves.fastOutSlowIn,
                );
              }
              setState(() {
                widget.deposits.add(CustomDeposit(name, amount));
              });
            }));
  }
}
