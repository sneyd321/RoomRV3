import 'package:flutter/material.dart';
import 'package:notification_app/bloc/selection/selection.dart';
import 'package:notification_app/lease/tenancy_terms/partial_period/partial_period_bloc.dart';
import 'package:notification_app/lease/tenancy_terms/partial_period/partial_period_error_key.dart';
import 'package:notification_app/lease/tenancy_terms/partial_period/selection/partial_period_enabled_switch.dart';

class PartialPeriodEnabledSelection extends Selection {
  final PartialPeriodBloc partialPeriodBloc = PartialPeriodBloc();

  @override
  Widget build(Object? error) {
    if (error != null) {
      Map<Enum, String> errorObject = error as Map<Enum, String>;
      if (errorObject.containsKey(errorKey)) {
        value = false;
      }
    }
    value = partialPeriodBloc.getSelectionValue(errorKey);
    return PartialPeriodEnabledSwitch(
        positiveOption: positiveOption,
        negativeOption: negativeOption,
        value: value,
        bloc: partialPeriodBloc);
  }

  @override
  void setErrorKey() {
    errorKey = PartialPeriodErrorKey.isEnabled;
  }

  @override
  void setNegativeOption() {
    negativeOption = "No, the first month is not a partial period";
  }

  @override
  void setPositiveOption() {
    positiveOption = "Yes, the first month a partial period";
  }
}
