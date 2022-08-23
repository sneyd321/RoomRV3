import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/payment_option.dart';
import 'package:notification_app/business_logic/list_items/rent_discount.dart';
import 'package:notification_app/widgets/Cards/PaymentOptionCard.dart';
import 'package:notification_app/widgets/Cards/RentDiscoutCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameAmountForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemStateWrapper.dart';

class RentDiscountsList extends StatefulWidget {
  final List<RentDiscount> rentDiscounts;
  const RentDiscountsList({Key? key, required this.rentDiscounts})
      : super(key: key);

  @override
  State<RentDiscountsList> createState() => _RentDiscountsListState();
}

class _RentDiscountsListState extends State<RentDiscountsList> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SliverAddItemStateWrapper(
      items: widget.rentDiscounts,
      noItemsText: "No Discounts",
      addButtonTitle: "Add Discount",
      scrollController: scrollController,
      builder: (context, index) {
        RentDiscount rentDiscount = widget.rentDiscounts[index];
        return RentDiscountCard(
            rentDiscount: rentDiscount,
            onItemRemoved: (context, rentDiscount) {
              setState(() {
                widget.rentDiscounts.remove(rentDiscount);
              });
            });
      },
      form: AddNameAmountForm(
        names: [],
        onSave: (BuildContext context, name, amount) {
          if (widget.rentDiscounts.isNotEmpty) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
            );
          }
          setState(() {
            widget.rentDiscounts.add(CustomRentDiscount(name, amount));
          });
        },
      ),
    );
  }
}
