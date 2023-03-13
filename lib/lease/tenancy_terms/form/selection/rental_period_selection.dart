import 'package:flutter/material.dart';
import 'package:notification_app/lease/tenancy_terms/form/field/end_date_field.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/selection/selection.dart';
import 'package:notification_app/lease/tenancy_terms/tenancy_terms_error_key.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class RentalPeriodSelection extends Selection {
  late final AnimationController animationController;
  RentalPeriodSelection() {}

  @override
  void setTickerProvider(TickerProvider tickerProvider) {
    super.setTickerProvider(tickerProvider);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: tickerProvider);
  }

  @override
  Widget build(Object? error) {
    String groupValue = bloc.getStringSelectionValue(errorKey);
    List<Widget> children = [
      RadioListTile<String>(
          contentPadding: const EdgeInsets.all(0),
          title: const Text("Bi Weekly (Twice a month)"),
          value: "BiWeekly",
          groupValue: groupValue,
          onChanged: (value) {
            animationController.reverse();
            bloc.setEnumSelectionChange(RentalPeriodOption.biWeekly, errorKey);
          }),
      RadioListTile<String>(
          contentPadding: const EdgeInsets.all(0),
          title: const Text("Weekly"),
          value: "Weekly",
          groupValue: groupValue,
          onChanged: (value) {
            animationController.reverse();
            bloc.setEnumSelectionChange(RentalPeriodOption.weekly, errorKey);
          }),
      RadioListTile<String>(
          contentPadding: const EdgeInsets.all(0),
          title: const Text("Monthly"),
          value: "Monthly",
          groupValue: groupValue,
          onChanged: (value) {
            animationController.reverse();
            bloc.setEnumSelectionChange(RentalPeriodOption.monthly, errorKey);
          }),
      Column(
        children: [
          RadioListTile<String>(
              contentPadding: const EdgeInsets.all(0),
              title: const Text("Fixed Term"),
              value: "Fixed Term",
              groupValue: groupValue,
              onChanged: (value) {
                animationController.forward();
                bloc.setEnumSelectionChange(
                    RentalPeriodOption.fixedTerm, errorKey);
              }),
          SizeTransition(
              sizeFactor: animationController,
              child: FormBuilder(bloc, tickerProvider: tickerProvider)
                  .add(EndDateField(left: 8, right: 8))
                  .build(error)
                  .first)
        ],
      ),
    ];
    return Wrap(
      children: children,
    );
  }

  @override
  void setErrorKey() {
    errorKey = TenancyTermsErrorKey.rentalPeriod;
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
