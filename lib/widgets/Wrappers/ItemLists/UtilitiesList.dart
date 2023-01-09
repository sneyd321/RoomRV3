import 'package:flutter/cupertino.dart';
import 'package:notification_app/widgets/Cards/UtilityCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemStateWrapper.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class UtilitiesList extends StatefulWidget {
  final List<Utility> utilities;
  const UtilitiesList({Key? key, required this.utilities}) : super(key: key);

  @override
  State<UtilitiesList> createState() => _UtilitiesListState();
}

class _UtilitiesListState extends State<UtilitiesList> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SliverAddItemStateWrapper(
      shirnkWrap: false,
      items: widget.utilities,
      addButtonTitle: "Add Utility",
      noItemsText: "No Utilities",
      builder: (contxt, index) {
        Utility utility = widget.utilities[index];
        return UtiltiyCard(
            utility: utility,
            onItemRemoved: (context, utility) {
              setState(() {
                widget.utilities.remove(utility);
              });
            });
      },
      form: AddNameForm(
        onSave: ((context, name) {
          if (widget.utilities.isNotEmpty) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
            );
          }
          setState(() {
            widget.utilities.add(CustomUtility(name));
          });
        }),
        names: [],
      ),
      scrollController: scrollController,
    );
  }
}
