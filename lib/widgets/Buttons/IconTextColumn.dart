import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class IconTextColumn extends StatelessWidget {
  final IconData icon;
  final String text;
  final double profileSize;
  final double iconSize;
  final double textSize;
  final Color profileColor;
  final Color iconColor;
  final Color textColor;
  final String profileURL;

  final void Function() onClick;
  const IconTextColumn(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onClick,
      this.profileSize = 24.0,
      this.iconSize = 24.0,
      this.textSize = 14,
      this.profileURL = "",
      this.iconColor = Colors.black,
      this.textColor = Colors.white,
      this.profileColor = Colors.white})
      : super(key: key);

  Widget getIconTextColumn(Widget profilePicture) {
    return SizedBox(
      width: (profileSize * 2) + 16,
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: profileColor,
                  radius: profileSize,
                  child: profilePicture),
              const SizedBox(
                height: 8,
              ),
              Flexible(
                child: Text(
                  text,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: textSize,
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: http.get(Uri.parse(profileURL)),
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        return getIconTextColumn(Image.network(
          profileURL,
          errorBuilder: (context, error, stackTrace) {
            return
                Icon(icon, size: iconSize, color: iconColor);
          },
        ));
      },
    );
  }
}
