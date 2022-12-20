import 'package:flutter/material.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/widgets/Forms/Form/TenancyTermsForm.dart';

import '../../business_logic/house.dart';
import '../../widgets/buttons/SecondaryActionButton.dart';

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
               Container(
                 margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                 child: SecondaryActionButton(text: "Update Tenancy Terms", onClick: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    runMutation({
                      "houseId": widget.house.houseId,
                      "tenancyTerms": widget.house.lease.tenancyTerms.toJson()
                    });
                  }
              }),
               )
            ],
          );
        });
  }
}
