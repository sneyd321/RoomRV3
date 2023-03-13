import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class DetailCard extends StatelessWidget {
  final Detail detail;
  final void Function(BuildContext context, Detail detail) onItemRemoved;
  const DetailCard(
      {Key? key, required this.detail, required this.onItemRemoved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.label),
        title: Text(detail.name),
        trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              onItemRemoved(context, detail);
            }),
      ),
    );
  }
}
