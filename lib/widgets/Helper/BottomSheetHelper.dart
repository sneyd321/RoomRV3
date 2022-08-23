import 'package:flutter/material.dart';

class BottomSheetHelper {

  final Widget form;

  BottomSheetHelper(this.form);



  void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(children: [
              form
            ]),
          ),
        );
      },
    );
  }
}
