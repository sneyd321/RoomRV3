import 'package:flutter/material.dart';

class SuggestedFormField extends StatefulWidget {


  final String label;
  final IconData icon;
  final void Function(String? value) onSaved;
  final String? Function(String? value) onValidate;
  final List<String> suggestedNames;
  final TextEditingController textEditingController;

  const SuggestedFormField({Key? key, required this.label, required this.icon, required this.onSaved, required this.onValidate, required this.suggestedNames, required this.textEditingController}) : super(key: key);

  @override
  State<SuggestedFormField> createState() => _SuggestedFormFieldState();
}

class _SuggestedFormFieldState extends State<SuggestedFormField> {
  
  String _enteredText = "";
  final int maxCharacterLength = 100;
  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = widget.suggestedNames;
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          margin:
              const EdgeInsets.all(8),
          child: TextFormField(
            controller: widget.textEditingController,
            keyboardType: TextInputType.name,
            maxLines: null,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              errorBorder:
                  const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                  
              prefixIcon: Icon(widget.icon),
              labelText: widget.label,
            ),
            onSaved: (String? value) {
              widget.onSaved(value);
            },
            validator: (String? value) {
              return widget.onValidate(value);
            },
            
            onChanged: (value) {
              setState(() {
                _enteredText = value;
                if (_enteredText.isEmpty) {
                  filteredList = widget.suggestedNames;
                }
                else {
                  filteredList = widget.suggestedNames
                    .where((name) => name.startsWith(_enteredText))
                    .toList();
                }
                
              
              });
            },
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: filteredList.length < 3 ? filteredList.length : 3,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  child: Card(
                    child: ListTile(
                      title: Text(filteredList[index]),
                      onTap: () {
                        setState(() {
                          widget.textEditingController.text = widget.suggestedNames[index];
                          widget.textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: widget.textEditingController.text.length));
                          filteredList = [];
                        });
                      },
                    ),
                  ));
            })
      ],
    );
  }
}
