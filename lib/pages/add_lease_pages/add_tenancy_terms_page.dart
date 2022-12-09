import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Forms/Form/TenancyTermsForm.dart';

import '../../graphql/mutation_helper.dart';
import '../../graphql/graphql_client.dart';
import '../../widgets/Buttons/CallToActionButton.dart';
import '../../widgets/Buttons/SecondaryActionButton.dart';

class AddTenancyTermsPage extends StatefulWidget {
  final Lease lease;
  final Landlord landlord;
  final Function(BuildContext context) onBack;
  const AddTenancyTermsPage(
      {Key? key,
      required this.onBack,
      required this.lease,
      required this.landlord})
      : super(key: key);

  @override
  State<AddTenancyTermsPage> createState() => _AddTenancyTermsPageState();
}

class _AddTenancyTermsPageState extends State<AddTenancyTermsPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onBack(BuildContext context) {
    widget.onBack(context);
  }

  void onNext(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      showDialog(
          context: context,
          builder: (context) {
            return GraphQLProvider(
                client: GQLClient().getClient(),
                child: MutationHelper(
                    mutationName: 'createHouse',
                    onComplete: (json) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    builder: ((runMutation) {
                      return AlertDialog(
                          actions: [
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                runMutation({
                                  "landlord": widget.landlord.toLandlordJson(),
                                  "lease": widget.lease.toJson()
                                });
                              },
                            ),
                          ],
                          content: Row(
                            children: const [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  "This action will create:\n- A lease agreement available for download and your signature in notification feed\n- A house key to invite tenants\n- The ability to edit the lease\n\nFor security purposes you will be required to log back in.\n\nWould you like to continue?",
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ));
                    })));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: SecondaryActionButton(
                  text: "Back",
                  onClick: () {
                    onBack(context);
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: CallToActionButton(
                  text: "Create",
                  onClick: () {
                    onNext(context);
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
