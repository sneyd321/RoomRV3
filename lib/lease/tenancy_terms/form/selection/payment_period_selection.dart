import 'package:flutter/material.dart';
import 'package:notification_app/lease/tenancy_terms/tenancy_terms_bloc.dart';
import 'package:notification_app/bloc/selection/selection.dart';
import 'package:notification_app/lease/tenancy_terms/tenancy_terms_error_key.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class PaymentPeriodSelection extends Selection {
  @override
  Widget build(Object? error) {
    String groupValue = bloc.getStringSelectionValue(errorKey);
    List<Widget> children = [
      RadioListTile<String>(
          contentPadding: const EdgeInsets.all(0),
          title: const Text("Month"),
          value: "Monthly",
          groupValue: groupValue,
          onChanged: (value) {
            bloc.setEnumSelectionChange(PaymentPeriodOption.monthly, errorKey);
          }),
      RadioListTile<String>(
          contentPadding: const EdgeInsets.all(0),
          title: const Text("Week"),
          value: "Weekly",
          groupValue: groupValue,
          onChanged: (value) {
            bloc.setEnumSelectionChange(PaymentPeriodOption.weekly, errorKey);
          }),
      RadioListTile<String>(
          contentPadding: const EdgeInsets.all(0),
          title: const Text("Day to Day"),
          value: "Daily",
          groupValue: groupValue,
          onChanged: (value) {
            bloc.setEnumSelectionChange(PaymentPeriodOption.daily, errorKey);
          }),
    ];
    return Wrap(
      children: children,
    );
  }

  @override
  void setErrorKey() {
    errorKey = TenancyTermsErrorKey.paymentPeriod;
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
