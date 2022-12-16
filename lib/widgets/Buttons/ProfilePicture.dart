import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProfilePicture extends StatelessWidget {
  final IconData icon;
  final String text;
  final double profileSize;
  final double iconSize;
  final double textSize;
  final Color profileColor;
  final Color iconColor;
  final Color textColor;
  final String profileURL;
  final String tempImagePath;

  final void Function() onClick;
  const ProfilePicture(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onClick,
      this.profileSize = 24.0,
      this.iconSize = 24.0,
      this.textSize = 14,
      this.profileURL = "",
      this.tempImagePath = "",
      this.iconColor = Colors.black,
      this.textColor = Colors.white,
      this.profileColor = Colors.white})
      : super(key: key);

  Image getImage(Response response) {
    if (response.contentLength! > 4273) {
      return Image.network(
        
        profileURL,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset("assets/profile1.jpg");
        },
      );
    }
    return Image.asset("assets/profile1.jpg");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: http.get(Uri.parse(profileURL)),
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        Response response = snapshot.data!;

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
                    backgroundImage: getImage(response).image,
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
