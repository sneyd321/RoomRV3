import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/widgets/Buttons/ProfilePicture.dart';

class MemoryPhoto extends StatelessWidget {
  final String text;
  final double profileSize;
  final double iconSize;
  final double textSize;
  final Color profileColor;
  final Color iconColor;
  final Color textColor;
  final Future<Uint8List>? bytes;

  final void Function() onClick;
  const MemoryPhoto(
      {Key? key,
      required this.text,
      required this.onClick,
      this.profileSize = 24.0,
      this.iconSize = 24.0,
      this.textSize = 14,
      required this.bytes,
      this.iconColor = Colors.black,
      this.textColor = Colors.white,
      this.profileColor = Colors.white})
      : super(key: key);

  Image getImage(Uint8List content) {
    if (content.isNotEmpty) {
      return Image.memory(
        content,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset("assets/profile1.jpg");
        },
      );
    }
    return Image.asset("assets/profile1.jpg");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: bytes,
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

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
                    backgroundImage: getImage(snapshot.data!).image,
                    backgroundColor: profileColor,
                    radius: profileSize,
                  ),
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
      },
    );
  }
}
