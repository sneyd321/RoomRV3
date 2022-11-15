import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/deposit.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/RentForm.dart';

import '../../business_logic/house.dart';

class UpdateRentPage extends StatefulWidget {
  final House house;
  const UpdateRentPage({Key? key, required this.house}) : super(key: key);

  @override
  State<UpdateRentPage> createState() => _UpdateRentPageState();
}

class _UpdateRentPageState extends State<UpdateRentPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MutationHelper(
        mutationName: "updateRent",
        onComplete: ((json) {}),
        builder: (runMutation) {
          return Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: RentForm(
                  rent: widget.house.lease.rent,
                  formKey: formKey,
                ),
              )),
              SecondaryButton(Icons.update, "Update Rent", (context) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  runMutation({
                    "houseId": widget.house.lease.leaseId,
                    "rent": widget.house.lease.rent.toJson()
                  });
                }
              })
            ],
          );
        });
  }
}
