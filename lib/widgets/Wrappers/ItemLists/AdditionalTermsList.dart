import 'package:flutter/cupertino.dart';
import 'package:notification_app/widgets/Cards/AdditionalTermCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemStateWrapper.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class AdditonalTermsList extends StatefulWidget {
  final List<AdditionalTerm> additionalTerms;
  const AdditonalTermsList({Key? key, required this.additionalTerms}) : super(key: key);

  @override
  State<AdditonalTermsList> createState() => _AdditonalTermsListState();
}

class _AdditonalTermsListState extends State<AdditonalTermsList> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SliverAddItemStateWrapper(
      addButtonTitle: "Add Term",
      noItemsText: "No Additional Terms",
      items: widget.additionalTerms, builder: (context, index) {
      AdditionalTerm additionalTerm = widget.additionalTerms[index];
      return AdditionalTermCard(additionalTerm: additionalTerm, onItemRemoved: (BuildContext context, AdditionalTerm additonalTerm) {
        setState(() {
          widget.additionalTerms.remove(additonalTerm);
        });
        },);
    }, form: AddNameForm(names: [], onSave: (BuildContext context, name) { 
      if (widget.additionalTerms.isNotEmpty) {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(seconds: 6),
                  curve: Curves.fastOutSlowIn,
                );
              }
      setState(() {
        widget.additionalTerms.add(CustomTerm(name));
      });
     }, ), scrollController: scrollController,);
  }
}