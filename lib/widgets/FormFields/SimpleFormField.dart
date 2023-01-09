import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class SimpleFormField extends StatefulWidget {
  final String label;
  final IconData icon;
  final void Function(String? value) onSaved;
  final Field field;
  final TextEditingController textEditingController;

  const SimpleFormField(
      {Key? key,
      required this.label,
      required this.icon,
      required this.textEditingController,
      required this.onSaved,
      required this.field})
      : super(key: key);

  @override
  State<SimpleFormField> createState() => SimpleFormFieldState();
}

class SimpleFormFieldState extends State<SimpleFormField> {
  String _enteredText = "";
  final int maxCharacterLength = 100;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0, top: 8),
      child: TextFormField(
        controller: widget.textEditingController,
        maxLength: maxCharacterLength,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            counterText:
                '${widget.textEditingController.text.length.toString()}/$maxCharacterLength',
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            prefixIcon: Icon(widget.icon),
            labelText: widget.label,
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  widget.textEditingController.text = "";
                });
              },
            )),
        onSaved: (String? value) {
          widget.onSaved(value);
        },
        onChanged: (value) {
          setState(() {
            _enteredText = value;
          });
        },
        validator: (String? value) {
          widget.field.value = value!;
          return widget.field.validate();
        },
        inputFormatters: [LengthLimitingTextInputFormatter(maxCharacterLength)],
      ),
    );
  }
}
