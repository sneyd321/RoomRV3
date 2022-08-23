import 'package:flutter/material.dart';
import 'Button.dart';

class SecondaryButton extends StatelessWidget {

  final IconData _iconData;
  final String _text;
  final void Function(BuildContext context) _onClick;

  const SecondaryButton(this._iconData, this._text, this._onClick, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        color: Colors.white,
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16),
        child: OutlinedButton(
          onPressed: () {
            _onClick(context);
          }, 
          child: Button(iconData: _iconData, text: _text, color: Colors.blue)
        )
      
    );
  }

}



