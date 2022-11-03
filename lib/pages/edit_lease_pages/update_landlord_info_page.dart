import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordInfoForm.dart';

import '../../graphql/mutation_helper.dart';

class UpdateLandlordInfoPage extends StatefulWidget {
  final Lease lease;
  const UpdateLandlordInfoPage({
    Key? key,
    required this.lease,
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
                    landlordInfo: widget.lease.landlordInfo,
                    formKey: formKey,
                  ),
                ]),
              ),
              SecondaryButton(Icons.update, "Update Landlord Info", (context) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  runMutation({
                    "leaseId": widget.lease.leaseId,
                    "landlordInfo": widget.lease.landlordInfo.toJson()
                  });
                }
              })
            ],
          );
        }),
        mutationName: 'updateLandlordInfo',
        onComplete: (json) {},
    );
  }
}
