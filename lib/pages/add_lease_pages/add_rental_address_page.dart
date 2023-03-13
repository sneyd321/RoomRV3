import 'package:flutter/material.dart';
import 'package:notification_app/lease/rental_address/form/rental_address_form.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class AddRentalAddressPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddRentalAddressPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddRentalAddressPage> createState() => _AddRentalAddressPageState();
}

class _AddRentalAddressPageState extends State<AddRentalAddressPage> {

  @override
  Widget build(BuildContext context) {
    return RentalAddressForm(
      lease: widget.lease,
      onUpdate: (RentalAddress rentalAddress) {
        widget.onNext(context);
      },
    );
  }
}
