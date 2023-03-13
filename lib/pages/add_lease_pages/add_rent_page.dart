import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:notification_app/buttons/CallToActionButton.dart';
import 'package:notification_app/bloc/helper/SecondaryActionButton.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class AddRentPage extends StatefulWidget {
  final Lease lease;
  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddRentPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddRentPage> createState() => _AddRentPageState();
}

class _AddRentPageState extends State<AddRentPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onNext(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.lease.rentDeposits
          .insert(0, RentDeposit(widget.lease.rent.baseRent));
      widget.onNext(context);
    }
  }

  void onBack(BuildContext context) {
    widget.onBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: SecondaryActionButton(
                  text: "Back",
                  onClick: () {
                    onBack(context);
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: CallToActionButton(
                  text: "Next",
                  onClick: () {
                    onNext(context);
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
