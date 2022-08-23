import 'package:flutter/material.dart';


class CardSliverListView extends StatefulWidget {
  final List items;
  final String noItemsText;
  final bool shrinkWrap;
  final bool lazyLoad;
  final ScrollController controller;
  final Widget? Function(BuildContext context, int index) builder;

  const CardSliverListView({Key? key, required this.items, required this.builder, this.noItemsText = "No Items", this.shrinkWrap = false, this.lazyLoad = true, required this.controller})
      : super(key: key);

  @override
  State<CardSliverListView> createState() => _CardSliverListViewState();
}

class _CardSliverListViewState extends State<CardSliverListView> {


  @override
  Widget build(BuildContext context) {
    if (widget.items.isNotEmpty) {
      return CustomScrollView(
        controller: widget.controller,
        shrinkWrap: widget.shrinkWrap,
        semanticChildCount: widget.items.length,
        cacheExtent: 1000,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(widget.builder, childCount: widget.items.length))
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
