import 'package:flutter/material.dart';

class IconTextColumn extends StatelessWidget {
  final IconData icon;
  final String text;
  final double profileSize;
  final double iconSize;
  final double textSize;
  final Color profileColor;
  final Color iconColor;
  final Color textColor;

  final void Function() onClick;
  const IconTextColumn(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onClick,
      this.profileSize = 24.0,
      this.iconSize = 24.0,
      this.textSize = 14,
      this.iconColor = Colors.black,
      this.textColor = Colors.white,
      this.profileColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            backgroundColor: profileColor,
            radius: profileSize,
            child: Icon(icon, size: iconSize, color: iconColor),
          ),
          const SizedBox(
            height: 8,
          ),
          
              Flexible(
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(color: textColor, fontSize: textSize),
                  ),
                ),
              ),
            
        ]),
      ),
    );
  }
}
