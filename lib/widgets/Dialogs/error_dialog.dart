import 'package:flutter/material.dart';

class ErrorDialog {
  final String errorText;
  late AlertDialog alert;

  ErrorDialog(this.errorText) {
    alert = AlertDialog(content: build()!);
  }

  Widget? build() {
    return Wrap(
      children: [
        const CircleAvatar(child: Icon(Icons.error),),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(errorText)),
      ],
    );
  }

  void show(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void close(BuildContext context) {
    Navigator.pop(context);
  }
}
