import 'package:flutter/material.dart';
import 'package:notification_app/lease/tenancy_terms/form/tenancy_terms_form.dart';
import 'package:notification_app/dialog/create_house_dialog.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


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

  @override
  Widget build(BuildContext context) {
    return TenancyTermsForm(
      lease: widget.lease,
      onUpdate: (TenancyTerms tenancyTerms) {
        showDialog(
            context: context,
            builder: (context) {
              return CreateHouseDialog(
                  landlord: widget.landlord, lease: widget.lease);
            });
      },
    );
  }
}
