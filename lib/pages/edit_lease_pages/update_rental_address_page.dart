import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/RentalAddressForm.dart';

class UpdateRentalAddressPage extends StatefulWidget {
  final Lease lease;

  const UpdateRentalAddressPage(
      {Key? key,  required this.lease})
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
                      rentalAddress: widget.lease.rentalAddress,
                      formKey: formKey,
                    ),
                  ])),
              SecondaryButton(Icons.update, "Update Rental Address", (context) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  runMutation({
                    "leaseId": widget.lease.leaseId,
                    "rentalAddress": widget.lease.rentalAddress.toJson()
                  });
                } else {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              })
            ],
          );
        });
  }
}
