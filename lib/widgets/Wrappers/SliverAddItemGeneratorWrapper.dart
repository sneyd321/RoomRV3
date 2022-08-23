import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/FormRow/HalfRow.dart';
import 'package:notification_app/widgets/Helper/BottomSheetHelper.dart';
import 'package:notification_app/widgets/Listviews/CardSliverGenerator.dart';
import 'package:notification_app/widgets/Listviews/CardSliverListView.dart';

class SliverAddItemGeneratorWrapper<T> extends StatefulWidget {
  final List<T> items;
  final List<String> suggestedNames;
  final Widget Function(int index) generator;
  final String addButtonTitle;
  final Widget form;
  final bool shirnkWrap;
  final String noItemsText;
  const SliverAddItemGeneratorWrapper({Key? key, 
  required this.items, 
  required this.generator, 
  required this.form, this.suggestedNames = const [], this.addButtonTitle = "Add Item", this.shirnkWrap=false, this.noItemsText = "No Items"}) : super(key: key);

  @override
  State<SliverAddItemGeneratorWrapper> createState() => _SliverAddItemGeneratorWrapperState();
}

class _SliverAddItemGeneratorWrapperState extends State<SliverAddItemGeneratorWrapper> {
  void addItem(BuildContext context) {
    BottomSheetHelper(widget.form).show(context);
  }

  Widget getCardSliverListView(bool shrinkWrap) {
    if (shrinkWrap){
      return CardSliverGenerator(items: widget.items, generator: widget.generator, shrinkWrap: shrinkWrap,noItemsText: widget.noItemsText);
    }
    return Expanded(child: CardSliverGenerator(items: widget.items, generator: widget.generator, shrinkWrap: shrinkWrap,noItemsText: widget.noItemsText));
    
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getCardSliverListView(widget.shirnkWrap),
       Container(
          margin: const EdgeInsets.only(top: 8),
          child: HalfRow(child: SecondaryButton(Icons.add, widget.addButtonTitle, addItem)))
      ],
    );
  }
}