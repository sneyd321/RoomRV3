import 'package:flutter/material.dart';

class CardSliverGridView extends StatefulWidget {
  final List items;
  final String noItemsText;
  final double childAspectRatio;
  final Widget? Function(BuildContext context, int index) builder;
  const CardSliverGridView(
      {Key? key,
      required this.items,
      this.noItemsText = "No Items",
      required this.builder, required this.childAspectRatio,})
      : super(key: key);

  @override
  State<CardSliverGridView> createState() => _CardSliverGridViewState();
}

class _CardSliverGridViewState extends State<CardSliverGridView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return CustomScrollView(
      slivers: [
        SliverGrid(
            delegate: SliverChildBuilderDelegate(
              widget.builder,
              childCount: widget.items.length,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: (MediaQuery.of(context).size.width) / 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: widget.childAspectRatio))
      ],
    );
  }
}
