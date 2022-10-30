import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/additional_term.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/AdditionalTermsList.dart';
import 'package:notification_app/widgets/mutations/additional_term_mutation.dart';


class UpdateAdditionalTermsPage extends StatefulWidget {
  final Lease lease;

  final Function(BuildContext context) onUpdate;
  const UpdateAdditionalTermsPage(
      {Key? key,
      required this.onUpdate,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateAdditionalTermsPage> createState() => _UpdateAdditionalTermsPageState();
}

class _UpdateAdditionalTermsPageState extends State<UpdateAdditionalTermsPage> {
  String errorText = "";

  bool validate() {
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
      widget.onUpdate(context);
      return true;
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
    return false;
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
        UpdateAdditionalTermsMutation(lease: widget.lease, onComplete: ((context, additionalTerm) {
          
        }), validate: validate)
      ],
    );
  }
}
