import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_app/bloc/fields/field.dart';

abstract class NumberField extends Field {

  NumberField({double? top, double? left, double? right, double? bottom, double? width})
      : super(
            top: top, left: left, right: right, bottom: bottom, width: width);

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
        textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length),
        );
      }
    }
    return Container(
      margin: EdgeInsets.only(top: top ?? 0, left: left ?? 0, right: right ?? 0, bottom: bottom ?? 0),
      width: width,
      child: Focus(
        onFocusChange: (value) {
          if (value == false) {
            bloc.setTextChanged(textEditingController.text, errorKey);
          }
        },
        child: TextFormField(
          controller: textEditingController,
          maxLength: maxCharacterLength,
          keyboardType: TextInputType.number,
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
                  bloc.setTextChanged("", errorKey);
                },
              )),
          onSaved: (String? value) {
            bloc.setTextChanged(value!, errorKey);
          },
       
          validator: (String? value) {
            return bloc.setTextChanged(value!, errorKey);
          },
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9\.,]'))],
        ),
      ),
    );
  }
}
