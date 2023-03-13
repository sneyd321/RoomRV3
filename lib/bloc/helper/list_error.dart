import 'package:flutter/material.dart';

class ListError extends StatelessWidget {
  final String error;
  const ListError({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        alignment: Alignment.centerLeft,
        child: Text(
          error,
          style: const TextStyle(color: Colors.red),
        ));
  }



}