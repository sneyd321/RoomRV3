import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_app/bloc/form_builder/form_item.dart';
import '../bloc.dart';

abstract class Field extends FormItem {
  IconData icon = Icons.abc;
  String label = "";
  Enum errorKey = ErrorKey.empty;

  TextEditingController textEditingController = TextEditingController();
  final int maxCharacterLength = 100;
  String? cachedText;
  String? errorText;

  void onTextChange() {
    bloc.setTextChanged(textEditingController.text, errorKey);
  }

  @override
  void dispose() {
    textEditingController.dispose();
  }

  Field({top, left, right, bottom, width})
      : super(
            top: top, left: left, right: right, bottom: bottom, width: width) {
    setErrorKey();
    setIcon();
    setLabel();
    textEditingController.addListener(onTextChange);
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
        textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length),
        );
      }
    }
    return Container(
      margin: EdgeInsets.only(
          top: top ?? 0,
          left: left ?? 0,
          right: right ?? 0,
          bottom: bottom ?? 0),
      width: width,
      child: TextFormField(
        controller: textEditingController,
        maxLength: maxCharacterLength,
        keyboardType: TextInputType.name,
        maxLines: null,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: errorText,
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            prefixIcon: Icon(icon),
            labelText: label,
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                textEditingController.clear();
              },
            )),
        onSaved: (String? value) {
          bloc.setTextChanged(value!, errorKey);
        },
        validator: (String? value) {
          return bloc.setTextChanged(value!, errorKey);
        },
        inputFormatters: [LengthLimitingTextInputFormatter(maxCharacterLength)],
      ),
    );
  }

  void setIcon();
  void setLabel();
  void setErrorKey();
}
