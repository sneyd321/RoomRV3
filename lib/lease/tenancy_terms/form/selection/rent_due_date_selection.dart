import 'package:flutter/material.dart';
import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/lease/tenancy_terms/tenancy_terms_bloc.dart';
import 'package:notification_app/bloc/selection/selection.dart';
import 'package:notification_app/lease/tenancy_terms/tenancy_terms_error_key.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class RentDueDateSelection extends Selection {

  @override
  Widget build(Object? error) {
    value = bloc.getSelectionValue(errorKey);
    List<Widget> children = [
      RadioListTile<String>(
          contentPadding: const EdgeInsets.all(0),
          title: const Text("First Day"),
          value: "First",
          groupValue: bloc.getStringSelectionValue(errorKey),
          onChanged: (value) {
            bloc.setEnumSelectionChange(RentDueDateOption.first, errorKey);
          }),
      RadioListTile<String>(
          contentPadding: const EdgeInsets.all(0),
          title: const Text("Last Day"),
          value: "Last",
          groupValue: bloc.getStringSelectionValue(errorKey),
          onChanged: (value) {
            bloc.setEnumSelectionChange(RentDueDateOption.last, errorKey);
          })
    ];
    return Wrap(
      children: children,
    );
  }

  @override
  void setErrorKey() {
    errorKey = TenancyTermsErrorKey.rentDueDate;
  }

  @override
  void setNegativeOption() {
    // TODO: implement setNegativeOption
  }

  @override
  void setPositiveOption() {
    // TODO: implement setPositiveOption
  }
}
