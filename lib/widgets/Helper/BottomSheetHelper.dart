import 'package:flutter/material.dart';

class BottomSheetHelper<T> {

  final Widget form;

  BottomSheetHelper(this.form);



  Future<T?> show(BuildContext context) {
    return showModalBottomSheet<T>(
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
