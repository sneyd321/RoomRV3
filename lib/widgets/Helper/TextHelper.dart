

import 'package:flutter/cupertino.dart';

class TextHelper extends StatelessWidget {

  final String text;

  const TextHelper({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 8, top: 8),
              child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),));
  }

}