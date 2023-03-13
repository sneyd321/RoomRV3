import 'package:flutter/material.dart';
import 'package:notification_app/bloc/form_builder/form_item.dart';
import '../bloc.dart';

abstract class Selection extends FormItem {
  Enum errorKey = ErrorKey.empty;
  String positiveOption = "";
  String negativeOption = "";
  late bool value;

  Selection({top, left, right, bottom, width})
      : super(
            top: top, left: left, right: right, bottom: bottom, width: width) {
    setErrorKey();
    setPositiveOption();
    setNegativeOption();
  }

  @override
  void dispose() {}

  @override
  Widget build(Object? error) {
    if (error != null) {
      Map<Enum, String> errorObject = error as Map<Enum, String>;
      if (errorObject.containsKey(errorKey)) {
        value = false;
      }
    }
    value = bloc.getSelectionValue(errorKey);
    return SwitchListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: value,
        title: Text(value ? positiveOption : negativeOption),
        onChanged: (value) {
  
          bloc.setSelectionChange(value, errorKey);
        });
  }

  void setErrorKey();
  void setPositiveOption();
  void setNegativeOption();
}
