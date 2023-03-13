import 'package:flutter/material.dart';
import 'package:notification_app/lease/tenancy_terms/form/tenancy_terms_form.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class UpdateTenancyTermsPage extends StatelessWidget {
  final Lease lease;
  const UpdateTenancyTermsPage({Key? key, required this.lease})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MutationHelper(
        mutationName: "updateTenancyTerms",
        onComplete: ((json) {}),
        builder: (runMutation) {
          return TenancyTermsForm(
            lease: lease,
            onUpdate: (TenancyTerms tenancyTerms) {
              runMutation({
                "houseId": lease.houseId,
                "tenancyTerms": lease.tenancyTerms.toTenancyTermsInput()
              });
            },
          );
        });
  }
}
