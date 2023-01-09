import 'package:flutter/material.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/widgets/Forms/Form/RentForm.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../../widgets/buttons/SecondaryActionButton.dart';

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
               Container(
                 margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                 child: SecondaryActionButton(text: "Update Rent", onClick: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    runMutation({
                      "houseId": widget.house.houseId,
                      "rent": widget.house.lease.rent.toJson()
                    });
                  }
              }),
               )
            ],
          );
        });
  }
}
