import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/business_logic/list_items/additional_term.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/AdditionalTermsList.dart';

import '../../business_logic/house.dart';
import '../../widgets/Buttons/SecondaryActionButton.dart';

class UpdateAdditionalTermsPage extends StatefulWidget {
  final House house;

  const UpdateAdditionalTermsPage(
      {Key? key, required this.house})
      : super(key: key);

  @override
  State<UpdateAdditionalTermsPage> createState() =>
      _UpdateAdditionalTermsPageState();
}

class _UpdateAdditionalTermsPageState extends State<UpdateAdditionalTermsPage> {
  String errorText = "";

  bool validate() {
    errorText = "";
    List<String> additionalTermsNames = widget.house.lease.additionalTerms
        .map<String>((AdditionalTerm additionalTerm) => additionalTerm.name)
        .toList();
    List<String> differences = {
      "Tenant Insurance",
      "Smoking",
    }.difference(additionalTermsNames.toSet()).toList();
    if (differences.isEmpty) {
      setState(() {});
      return true;
    }
    for (String element in differences) {
      errorText += errorText.isEmpty ? element : ", $element";
      switch (element) {
        case "Tenant Insurance":
          widget.house.lease.additionalTerms.insert(0, TenantInsuranceTerm());
          continue;
        case "Smoking":
          widget.house.lease.additionalTerms.insert(0, NoSmokingTerm());
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
    return MutationHelper(
        mutationName: "updateAdditionalTerms",
        onComplete: (json) {},
        builder: (runMutation) {
          return Column(
            children: [
              Expanded(
                  child: AdditonalTermsList(
                additionalTerms: widget.house.lease.additionalTerms,
              )),
              Container(
                  margin: const EdgeInsets.only(left: 8, bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    errorText,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  )),
               Container(
                margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                 child: SecondaryActionButton(text: "Update Additional Terms", onClick: () {
                  if (validate()) {
                    runMutation({
                      "houseId": widget.house.houseId,
                      "additionalTerms": widget.house.lease.additionalTerms
                          .map((additionalTerm) => additionalTerm.toJson())
                          .toList()
                    });
                  }
                             }),
               )
            ],
          );
        });
  }
}
