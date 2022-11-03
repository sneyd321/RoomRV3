import 'package:flutter/material.dart';

class LoadingDialog {
  late AlertDialog alert;

  LoadingDialog() {
    alert = AlertDialog(content: build());
  }

  Widget build() {
    return Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
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
    Navigator.popUntil(context, ((route) => route.isFirst));
  }
}
