import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/bloc/fields/date_picker.dart';
import 'package:notification_app/bloc/fields/field.dart';

abstract class DateField extends Field {
  DateTime currentDate = DateTime.now();
  DateField(
      {double? top, double? left, double? right, double? bottom, double? width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  void setIcon() {}

  @override
  void onTextChange() {

  }

  @override
  Widget build(Object? error) {
    if (error != null) {
      Map<Enum, String> errorObject = error as Map<Enum, String>;
      errorText = errorObject[errorKey];
    }
    if (error == null) {
      errorText = null;
      String? text = bloc.getFieldValue(errorKey);
      if (text != null && text.isNotEmpty && text != cachedText) {
        cachedText = text;
        textEditingController.text = text;
      }
    }
    return DatePicker(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        width: width,
        label: label,
        onSaved: (value) {
         
          bloc.setTextChanged(value!, errorKey);
        },
        onValidate: (value) {
       
          return bloc.setTextChanged(value!, errorKey);
        },
        textEditingController: textEditingController);
  }
}
