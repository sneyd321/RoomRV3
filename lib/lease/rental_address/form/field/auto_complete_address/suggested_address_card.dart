import 'package:flutter/material.dart';
import 'package:notification_app/lease/rental_address/rental_address_bloc.dart';
import 'package:notification_app/services/network.dart';
import 'package:notification_app/services/socketIO.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class SuggestedAddressCard extends StatefulWidget {
  final SuggestedAddress suggestedAddress;
  final RentalAddressBloc rentalAddressBloc;
  const SuggestedAddressCard(
      {Key? key,
      required this.suggestedAddress,
      required this.rentalAddressBloc})
      : super(key: key);

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
      onTap: () async {
        PredictedAddress address = await Network()
            .getPredictedAddress(widget.suggestedAddress.placesId);
        widget.rentalAddressBloc.updateFromPredictedAddress(address);
        SocketIO().clearStream();
      },
    ));
  }
}
