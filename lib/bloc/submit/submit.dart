import 'package:flutter/material.dart';
import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/bloc/helper/SecondaryActionButton.dart';
import 'package:notification_app/bloc/form_builder/form_item.dart';

class Submit extends FormItem {
  void Function() callback;
  String label;
  Submit(this.label, this.callback,
      {double? top, double? left, double? right, double? bottom, double? width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  Widget build(Object? error) {
    return Container(
      margin: EdgeInsets.only(
          top: top ?? 0,
          left: left ?? 0,
          right: right ?? 0,
          bottom: bottom ?? 0),
      width: width,
      child: SecondaryActionButton(text: label, onClick: callback),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
