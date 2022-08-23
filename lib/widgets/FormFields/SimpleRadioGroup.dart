import 'package:flutter/material.dart';

class SimpleRadioGroup extends StatefulWidget {
  final String radioGroup;
  final List<String> names;
  final bool isHorizontal;
  final void Function(BuildContext context, String? selected) onSelected;

  const SimpleRadioGroup(
      {Key? key,
      required this.radioGroup,
      required this.names,
      required this.onSelected, 
      required this.isHorizontal})
      : super(key: key);

  @override
  State<SimpleRadioGroup> createState() => _SimpleRadioGroupState();
}

class _SimpleRadioGroupState extends State<SimpleRadioGroup> {
  @override
  Widget build(BuildContext context) {
    var data = widget.names.map((name) {
      return Expanded(
        child: RadioListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(name),
            value: name,
            groupValue: widget.radioGroup,
            onChanged: (String? value) {
              widget.onSelected(context, value);
            }),
      );
    }).toList();
    return widget.isHorizontal ? Row(children: data,) : Column(children: data,);
  }
}
