import 'package:flutter/material.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/widgets/Forms/Form/RentalAddressForm.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../../widgets/buttons/SecondaryActionButton.dart';

class UpdateRentalAddressPage extends StatefulWidget {
  final House house;

  const UpdateRentalAddressPage(
      {Key? key,  required this.house})
      : super(key: key);

  @override
  State<UpdateRentalAddressPage> createState() =>
      _UpdateRentalAddressPageState();
}

class _UpdateRentalAddressPageState extends State<UpdateRentalAddressPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MutationHelper(
        mutationName: "updateRentalAddress",
        onComplete: ((json) {}),
        builder: (runMutation) {
          return Column(
            children: [
              Expanded(
                  child: ListView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                    RentalAddressForm(
                      rentalAddress: widget.house.lease.rentalAddress,
                      formKey: formKey,
                    ),
                  ])),
              Container(
                 margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: SecondaryActionButton(text: "Update Rental Address", onClick: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    runMutation({
                      "houseId": widget.house.houseId,
                      "rentalAddress": widget.house.lease.rentalAddress.toJson()
                    });
                  } else {
                    scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                    );
                  }
                }),
              )
            ],
          );
        });
  }
}
