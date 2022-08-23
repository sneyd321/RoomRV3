import 'package:flutter/material.dart';

class HalfRow extends StatelessWidget {
  final Widget child;
  const HalfRow({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(width: (MediaQuery.of(context).size.width) / 2,
      child: child,
    ));
  }



}