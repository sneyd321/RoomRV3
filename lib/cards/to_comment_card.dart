import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notification_app/main.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../buttons/ProfilePicture.dart';

class ToCommentCard extends StatelessWidget {
  final Comment comment;

  const ToCommentCard({Key? key, required this.comment}) : super(key: key);

  Widget getCommentType(Comment comment) {
    switch (comment.name) {
      case "text":
        return Text(
          comment.comment,
          softWrap: true,
          maxLines: 5,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.start,
        );
      case "image":
        var image = base64.decode(comment.comment.toString());
        return Image.memory(image);
      default:
        return Text(
          comment.comment,
          softWrap: true,
          maxLines: 5,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.start,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.orange),
                    child: getCommentType(comment),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4, right: 4, top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(comment.timestamp.getCurrentTimestamp()),
                  ),
                ],
              ),
            ),
            ProfilePicture(
              icon: Icons.account_circle,
                profileURL: comment.profileURL,
                text: comment.getFullName(),
                profileColor: Colors.blueGrey,
                textColor: Color(primaryColour),
                onClick: () {
                  const snackBar = SnackBar(
                    content: Text('To add photo go to more > edit profile'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }),
          ],
        ),
      ),
    );
  }
}
