import 'package:flutter/cupertino.dart';
import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/bloc/form_builder/form_item.dart';

class BlocText extends FormItem {
  String text;
  Enum errorKey = ErrorKey.empty;
  TextStyle? textStyle = const TextStyle();

  BlocText(this.text, {this.textStyle, double? top, double? left, double? right, double? bottom, double? width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  void setBloc(Bloc bloc) {
    super.setBloc(bloc);
    setErrorKey();
    setText();
  }

  @override
  Widget build(Object? error) {
    setText();
    return Container(
        margin: EdgeInsets.only(
            top: top ?? 0,
            left: left ?? 0,
            right: right ?? 0,
            bottom: bottom ?? 0),
        width: width,
        child: Text(
          text,
          style: textStyle,
        ));
  }

  @override
  void dispose() {}
  void setText() {}
  void setErrorKey() {}
}
