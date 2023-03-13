import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color color;

  const Button(
      {Key? key,
      this.iconData = Icons.ac_unit,
      this.text = "",
      this.color = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        children: [
          Icon(
            iconData,
            color: color,
          ),
          Expanded(
            child: Center(
                child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            )),
          )
        ],
      ),
    );
  }
}
