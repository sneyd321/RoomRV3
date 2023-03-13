import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final Function(String? value) onSaved;
  final String? Function(String? value) onValidate;
  final TextEditingController textEditingController;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;

  const DatePicker(
      {Key? key,
      required this.label,
      required this.onSaved,
      required this.onValidate,
      required this.textEditingController,
      this.left,
      this.top,
      this.right,
      this.bottom,
      this.width})
      : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: EdgeInsets.only(
          left: widget.left ?? 0.0,
          right: widget.right ?? 0.0,
          bottom: widget.bottom ?? 0.0,
          top: widget.top ?? 0.0),
      child: TextFormField(
        readOnly: true,
        controller: widget.textEditingController,
        keyboardType: TextInputType.datetime,
        maxLines: null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          prefixIcon: const Icon(Icons.date_range),
          suffixIcon: IconButton(
              onPressed: () {
                widget.textEditingController.clear();
              },
              icon: const Icon(Icons.clear)),
          labelText: widget.label,
        ),
        onSaved: widget.onSaved,
        validator: widget.onValidate,
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: currentDate,
              firstDate: DateTime(2015),
              lastDate: DateTime(2050));

          if (pickedDate != null && pickedDate != currentDate) {
            currentDate = pickedDate;
            DateFormat formatter = DateFormat('yyyy/MM/dd');
            String formatted = formatter.format(pickedDate);
            widget.textEditingController.text = formatted;
          }
        },
      ),
    );
  }
}
