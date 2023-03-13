import 'package:flutter/material.dart';
import 'package:notification_app/main.dart';


class CallToActionButton extends StatelessWidget {
  final String text;
  final Function() onClick;

  const CallToActionButton({Key? key, required this.text, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(18)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Color(primaryColour)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.white)))),
          onPressed: () async {
            onClick();
          },
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
    );
  }
}
