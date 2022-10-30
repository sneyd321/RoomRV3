import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordFormField extends StatefulWidget {
  final IconData icon;
  final String label;
  final String? Function(String? value) onValidate;

  final void Function(String? value) onSaved;
  final TextEditingController textEditingController;

  const PasswordFormField(
      {Key? key,
      required this.textEditingController,
      required this.onSaved,
      required this.label, required this.icon, required this.onValidate})
      : super(key: key);

  @override
  State<PasswordFormField> createState() => PasswordFormFieldState();
}

class PasswordFormFieldState extends State<PasswordFormField> {
  final int maxCharacterLength = 100;
  bool isPasswordVisible = false;

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
        obscureText: !isPasswordVisible,
        keyboardType: TextInputType.visiblePassword,
        maxLines: 1,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          counterText:
              '${widget.textEditingController.text.length.toString()}/$maxCharacterLength',
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          prefixIcon: const Icon(Icons.password),
          labelText: widget.label,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
        ),
        onSaved: (String? value) {
          widget.onSaved(value);
        },
        onChanged: (value) {
          setState(() {});
        },
        validator: (String? value) {
          return widget.onValidate(value);
        },
        inputFormatters: [LengthLimitingTextInputFormatter(maxCharacterLength)],
      ),
    );
  }
}
