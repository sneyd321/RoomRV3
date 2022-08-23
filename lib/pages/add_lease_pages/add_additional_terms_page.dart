import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/additional_term.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/business_logic/list_items/utility.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/Form/LandlordAddressForm.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/AdditionalTermsList.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/ServicesList.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/UtilitiesList.dart';

class AddAdditionalTermsPage extends StatefulWidget {
  final Lease lease;

  final Function(BuildContext context) onNext;
  final Function(BuildContext context) onBack;
  const AddAdditionalTermsPage(
      {Key? key,
      required this.onNext,
      required this.onBack,
      required this.lease})
      : super(key: key);

  @override
  State<AddAdditionalTermsPage> createState() => _AddAdditionalTermsPageState();
}

class _AddAdditionalTermsPageState extends State<AddAdditionalTermsPage> {
  String errorText = "";

  void onNextCallback(BuildContext context) {
    errorText = "";
    List<String> additionalTermsNames = widget.lease.additionalTerms
        .map<String>((AdditionalTerm additionalTerm) => additionalTerm.name)
        .toList();
    List<String> differences = {
      "Tenant Insurance",
      "Smoking",
    }.difference(additionalTermsNames.toSet()).toList();
    if (differences.isEmpty) {
      setState(() {});
      widget.onNext(context);
      return;
    }
    for (String element in differences) {
      errorText += errorText.isEmpty ? element : ", $element";
      switch (element) {
        case "Tenant Insurance":
          widget.lease.additionalTerms.insert(0, TenantInsuranceTerm());
          continue;
        case "Smoking":
          widget.lease.additionalTerms.insert(0, NoSmokingTerm());
          continue;
      }
    }
    setState(() {
      errorText += " additional term(s) required";
    });
  }

  void onBackCallback(BuildContext context) {
    widget.onBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: AdditonalTermsList(
          additionalTerms: widget.lease.additionalTerms,
        )),
        Container(
            margin: const EdgeInsets.only(left: 8, bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            )),
        TwoColumnRow(
            left: SecondaryButton(Icons.chevron_left, "Back", onBackCallback),
            right: PrimaryButton(Icons.chevron_right, "Next", onNextCallback))
      ],
    );
  }
}
