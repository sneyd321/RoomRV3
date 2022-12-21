import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Helper/BottomSheetHelper.dart';
import 'package:notification_app/widgets/Listviews/CardSliverListView.dart';

import '../buttons/SecondaryActionButton.dart';

class SliverAddItemStateWrapper<T> extends StatefulWidget {
  final List<T> items;
  final List<String> suggestedNames;
  final Widget? Function(BuildContext context, int index) builder;
  final String addButtonTitle;
  final Widget form;
  final bool shirnkWrap;
  final String noItemsText;
  final ScrollController scrollController;
  const SliverAddItemStateWrapper({Key? key, 
  required this.items, 
  required this.builder, 
  required this.form, this.suggestedNames = const [], this.addButtonTitle = "Add Item", this.shirnkWrap=false, this.noItemsText = "No Items", required this.scrollController}) : super(key: key);

  @override
  State<SliverAddItemStateWrapper> createState() => _SliverAddItemStateWrapperState();
}

class _SliverAddItemStateWrapperState extends State<SliverAddItemStateWrapper> {
  void addItem(BuildContext context) {
    BottomSheetHelper(widget.form).show(context);
  }

  Widget getCardSliverListView(bool shrinkWrap) {
    if (shrinkWrap){
      return CardSliverListView(items: widget.items, builder: widget.builder, shrinkWrap: shrinkWrap, noItemsText: widget.noItemsText, controller: widget.scrollController,);
    }
    return Expanded(child: CardSliverListView(items: widget.items, builder: widget.builder, shrinkWrap: shrinkWrap, noItemsText: widget.noItemsText, controller: widget.scrollController,));
    
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getCardSliverListView(widget.shirnkWrap),
       Container(
          margin: const EdgeInsets.all( 8),
          alignment: Alignment.centerLeft,
          child: SecondaryActionButton(text:widget.addButtonTitle, onClick: () {
            addItem(context);
          }))
      ],
    );
  }
}