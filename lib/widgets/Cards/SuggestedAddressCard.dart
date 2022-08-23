import 'package:flutter/material.dart';


import '../../business_logic/suggested_address.dart';

class SuggestedAddressCard extends StatefulWidget {
  final SuggestedAddress suggestedAddress;
  final Function(BuildContext context, SuggestedAddress suggestedAddress) onSuggestedAddress;
  const SuggestedAddressCard(this.suggestedAddress, this.onSuggestedAddress, {Key? key}) : super(key: key);

  @override
  State<SuggestedAddressCard> createState() => _SuggestedAddressCardState();
}

class _SuggestedAddressCardState extends State<SuggestedAddressCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.house_siding_outlined),
      title: Text(widget.suggestedAddress.primary),
      subtitle: Text(widget.suggestedAddress.secondary),
      onTap: () {
        widget.onSuggestedAddress(context, widget.suggestedAddress);
      },
    ));
  }
}
