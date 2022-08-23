

import 'package:flutter/material.dart';


class CardSliverGenerator extends StatefulWidget {
  final List items;
  final String noItemsText;
  final bool shrinkWrap;
  final Widget Function(int index) generator;

  const CardSliverGenerator({Key? key, required this.items, required this.generator, this.noItemsText = "No Items", this.shrinkWrap = false})
      : super(key: key);

  @override
  State<CardSliverGenerator> createState() => _CardSliverGeneratorState();
}

class _CardSliverGeneratorState extends State<CardSliverGenerator> {


 

  @override
  Widget build(BuildContext context) {
    if (widget.items.isNotEmpty) {
      return CustomScrollView(
        shrinkWrap: widget.shrinkWrap,
        cacheExtent: 1000.0,
        semanticChildCount: widget.items.length,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(List.generate(widget.items.length, widget.generator)))
        ],
      );
    } else {
      return Card(
        margin: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(widget.noItemsText),
        ),
      );
    }
  }
}
