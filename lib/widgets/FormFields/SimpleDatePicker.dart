import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SimpleDatePicker extends StatefulWidget {

  final String label;
  final Function(String? value) onSaved;
  final String? Function(String? value) onValidate;
  final TextEditingController textEditingController;

  const SimpleDatePicker({Key? key, required this.label, required this.onSaved, required this.onValidate, required this.textEditingController}) : super(key: key);




  @override
  State<SimpleDatePicker> createState() => _SimpleDatePickerState();
}


class _SimpleDatePickerState extends State<SimpleDatePicker> {

  DateTime currentDate = DateTime.now();
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0, top: 8),
      child: TextFormField(
        
        readOnly: true,
        controller: widget.textEditingController,
        keyboardType: TextInputType.datetime,
        maxLines: null,
    
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          prefixIcon: const Icon(Icons.date_range),
          labelText: widget.label,
        ),
        onSaved: (String? value) {
          widget.onSaved(value);
        },
        validator: (String? value) {
          return widget.onValidate(value);
        },
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime(2015),
          lastDate: DateTime(2050));
          if (pickedDate != null && pickedDate != currentDate) {
            setState(() {
              currentDate = pickedDate;
              DateFormat formatter = DateFormat('yyyy/MM/dd');
              String formatted = formatter.format(pickedDate);
              widget.textEditingController.text = formatted;
            });
          }
        },
     

      ),
    );
  }
}
