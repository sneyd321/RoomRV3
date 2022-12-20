import 'package:flutter/material.dart';
import 'package:notification_app/widgets/buttons/Button.dart';

class PrimaryButton extends StatelessWidget {

  final IconData _iconData;
  final String _text;
  final Function(BuildContext context) _onClick;

  const PrimaryButton(this._iconData, this._text, this._onClick, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
     return 
      Container(
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16),
        child: ElevatedButton(
          onPressed: () {
            _onClick(context);
          }, 
          child: Button(iconData: _iconData, text: _text, color: Colors.white)
        )
      
    ); 
  }
}






