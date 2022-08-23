import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Helper/TextHelper.dart';

class DetailCard extends StatelessWidget {
  final String detail;
  final void Function(BuildContext context, String detail) onItemRemoved;
  const DetailCard(
      {Key? key, required this.detail, required this.onItemRemoved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.label),
        title: TextHelper(text: detail),
        trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              onItemRemoved(context, detail);
            }),
      ),
    );
  }
}
