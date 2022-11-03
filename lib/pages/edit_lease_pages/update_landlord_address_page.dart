import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordAddressForm.dart';

class UpdateLandlordAddressPage extends StatefulWidget {
  final Lease lease;
  const UpdateLandlordAddressPage({Key? key, required this.lease}) : super(key: key);

  @override
  State<UpdateLandlordAddressPage> createState() =>
      _UpdateLandlordAddressPageState();
}

class _UpdateLandlordAddressPageState extends State<UpdateLandlordAddressPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MutationHelper(
        mutationName: "updateLandlordAddress",
        onComplete: ((json) {}),
        builder: (runMutation) {
          return Column(
            children: [
              Expanded(
                  child: ListView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                    LandlordAddressForm(
                      landlordAddress: widget.lease.landlordAddress,
                      formKey: formKey,
                    ),
                  ])),
              SecondaryButton(Icons.update, "Update Landlord Address",
                  (context) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  runMutation({
                    "leaseId": widget.lease.leaseId,
                    "landlordAddress": widget.lease.landlordAddress.toJson()
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
