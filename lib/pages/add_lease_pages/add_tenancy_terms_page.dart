import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/TenancyTermsForm.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';

import '../../graphql/mutation_helper.dart';
import '../../services/graphql_client.dart';

class AddTenancyTermsPage extends StatefulWidget {
  final Lease lease;
  final Landlord landlord;
  final Function(BuildContext context) onBack;
  const AddTenancyTermsPage(
      {Key? key, required this.onBack, required this.lease, required this.landlord})
      : super(key: key);

  @override
  State<AddTenancyTermsPage> createState() => _AddTenancyTermsPageState();
}

class _AddTenancyTermsPageState extends State<AddTenancyTermsPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void onBack(BuildContext context) {
    widget.onBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GQLClient().getClient(),
        child: MutationHelper(
          builder: (runMutation) {
            return Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: TenancyTermsForm(
                    tenancyTerms: widget.lease.tenancyTerms,
                    formKey: formKey,
                  ),
                )),
                TwoColumnRow(
                    left: SecondaryButton(Icons.chevron_left, "Back", onBack),
                    right: PrimaryButton(Icons.upload, "Create Lease",
                        (context) async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        runMutation({
                          "landlordId": widget.landlord.id,
                          "lease": widget.lease.toJson()
                        });
                      }
                    }))
              ],
            );
          },
          mutationName: 'createHouse',
          onComplete: (json) {
            House house = House.fromJson(json);
            Navigator.pop(context, house);
          },
        ));
  }
}
