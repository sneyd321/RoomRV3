import 'package:flutter/material.dart';
import 'package:notification_app/lease/rental_address/form/rental_address_form.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class UpdateRentalAddressPage extends StatefulWidget {
  final Lease lease;

  const UpdateRentalAddressPage({Key? key, required this.lease})
      : super(key: key);

  @override
  State<UpdateRentalAddressPage> createState() =>
      _UpdateRentalAddressPageState();
}

class _UpdateRentalAddressPageState extends State<UpdateRentalAddressPage> {
  @override
  Widget build(BuildContext context) {
    return MutationHelper(
        mutationName: "updateRentalAddress",
        onComplete: ((json) {}),
        builder: (runMutation) {
          return RentalAddressForm(
            lease: widget.lease,
            onUpdate: (RentalAddress rentalAddress) {
              widget.lease.updateRentalAddress(rentalAddress);
              runMutation({
                "houseId": widget.lease.houseId,
                "rentalAddress":
                    widget.lease.rentalAddress.toRentalAddressInput()
              });
            },
          );
        });
  }
}
