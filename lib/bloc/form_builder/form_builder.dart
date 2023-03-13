import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/bloc/form_builder/form_item.dart';
import 'package:notification_app/bloc/text/bloc_hint.dart';
import 'package:notification_app/bloc/text/bloc_text.dart';

class FormBuilder {
  Map<UniqueKey, FormItem> formItems = {};
  final Bloc bloc;
  final TickerProvider? tickerProvider;
  FormBuilder(this.bloc, {this.tickerProvider});

  FormBuilder add(FormItem formItem) {
    formItem.setBloc(bloc);
    if (tickerProvider != null) {
      formItem.setTickerProvider(tickerProvider!);
    }
    formItems[UniqueKey()] = formItem;
    return this;
  }

  FormBuilder addText(String text,
      {TextStyle? textStyle,
      double? top,
      double? left,
      double? right,
      double? bottom,
      double? width}) {
    return add(BlocText(text,
        textStyle: textStyle,
        top: top,
        bottom: bottom,
        left: left,
        right: right));
  }

  FormBuilder addHint(String text,
      {double? top,
      double? left,
      double? right,
      double? bottom,
      double? width}) {
    return add(BlocHint(text,
        top: top, left: left, right: right, bottom: bottom, width: width));
  }

  void dispose() {
    formItems.forEach((key, value) {
      value.dispose();
    });
  }

  List<Widget> build(Object? error) {
    List<Widget> children = [];
    formItems.forEach((key, value) {
      children.add(value.build(error));
    });
    return children;
  }
}
