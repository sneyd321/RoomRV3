import 'package:flutter/material.dart';
import 'package:notification_app/bloc/text/bloc_text.dart';

class BlocHint extends BlocText {
  BlocHint(String text, {top, left, right, bottom, width})
      : super(text,
            top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  Widget build(Object? error) {
    return Container(
      margin: EdgeInsets.only(
          top: top ?? 0,
          left: left ?? 0,
          right: right ?? 0,
          bottom: bottom ?? 0),
      width: width,
      child: Row(
        children: [
          const Icon(
            Icons.lightbulb,
            color: Colors.amber,
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
              child: Text(
            text,
            softWrap: true,
          ))
        ],
      ),
    );
  }
}
