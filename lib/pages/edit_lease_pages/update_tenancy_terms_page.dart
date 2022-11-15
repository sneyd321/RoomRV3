import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/TenancyTermsForm.dart';

import '../../business_logic/house.dart';

class UpdateTenancyTermsPage extends StatefulWidget {
  final House house;
  const UpdateTenancyTermsPage(
      {Key? key, required this.house})
      : super(key: key);

  @override
  State<UpdateTenancyTermsPage> createState() => _UpdateTenancyTermsPageState();
}

class _UpdateTenancyTermsPageState extends State<UpdateTenancyTermsPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return MutationHelper(
        mutationName: "updateTenancyTerms",
        onComplete: ((json) {}),
        builder: (runMutation) {
          return Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: TenancyTermsForm(
                  tenancyTerms: widget.house.lease.tenancyTerms,
                  formKey: formKey,
                ),
              )),
              SecondaryButton(Icons.update, "Update Tenancy Terms", (context) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  runMutation({
                    "houseId": widget.house.lease.leaseId,
                    "tenancyTerms": widget.house.lease.tenancyTerms.toJson()
                  });
                }
              })
            ],
          );
        });
  }
}
