import 'package:flutter/material.dart';


class DetailCardReadOnly extends StatelessWidget {
  final String detail;
  const DetailCardReadOnly(
      {Key? key, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.label),
        title: Text(detail),
        
      ),
    );
  }
}
