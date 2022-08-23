import 'package:flutter/material.dart';

class TwoColumnRow extends StatefulWidget {
  final Widget left;
  final Widget right;
  const TwoColumnRow({Key? key, required this.left, required this.right}) : super(key: key);

  @override
  State<TwoColumnRow> createState() => _TwoColumnRowState();
}

class _TwoColumnRowState extends State<TwoColumnRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: widget.left),
        Flexible(child: widget.right),
      ],
    );
  }
}
