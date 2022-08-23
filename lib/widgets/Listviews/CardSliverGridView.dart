import 'package:flutter/material.dart';

class CardSliverGridView extends StatefulWidget {
  final List items;
  final String noItemsText;
  final double heightRatio;
  final double widthRatio;
  final Widget? Function(BuildContext context, int index) builder;
  const CardSliverGridView({Key? key, required this.items, this.noItemsText = "No Items", required this.builder, this.heightRatio = 2, this.widthRatio = 2}) : super(key: key);

  @override
  State<CardSliverGridView> createState() => _CardSliverGridViewState();
}

class _CardSliverGridViewState extends State<CardSliverGridView> {
  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / widget.heightRatio;
    final double itemWidth = MediaQuery.of(context).size.width / widget.widthRatio;
    return CustomScrollView(
          slivers: [
            SliverGrid(
                delegate: SliverChildBuilderDelegate(widget.builder,
                childCount: widget.items.length,
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: (itemWidth / itemHeight)
                ))
          ],
        );
  }
}