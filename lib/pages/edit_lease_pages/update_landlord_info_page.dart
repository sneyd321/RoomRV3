import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordInfoForm.dart';

import '../../business_logic/house.dart';
import '../../graphql/mutation_helper.dart';
import '../../widgets/buttons/SecondaryActionButton.dart';

class UpdateLandlordInfoPage extends StatefulWidget {
  final House house;
  const UpdateLandlordInfoPage({
    Key? key,
    required this.house,
  }) : super(key: key);

  @override
  State<UpdateLandlordInfoPage> createState() => _UpdateLandlordInfoPageState();
}

class _UpdateLandlordInfoPageState extends State<UpdateLandlordInfoPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MutationHelper(
        builder: ((runMutation) {
          return Column(
            children: [
              Expanded(
                child:
                    ListView(physics: const BouncingScrollPhysics(), children: [
                  LandlordInfoForm(
                    landlordInfo: widget.house.lease.landlordInfo,
                    formKey: formKey,
                  ),
                ]),
              ),
              Container(
                 margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: SecondaryActionButton(text: "Update Landlord Info", onClick: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    runMutation({
                      "houseId": widget.house.houseId,
                      "landlordInfo": widget.house.lease.landlordInfo.toJson()
                    });
                  }
                }),
              )
            ],
          );
        }),
        mutationName: 'updateLandlordInfo',
        onComplete: (json) {},
    );
  }
}
