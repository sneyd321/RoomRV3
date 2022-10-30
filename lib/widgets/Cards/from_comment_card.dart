import 'dart:convert';

import 'package:flutter/material.dart';

import '../../business_logic/comment.dart';

class FromCommentCard extends StatelessWidget {
  final Comment comment;

  const FromCommentCard({Key? key, required this.comment}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              child: Icon(
                Icons.account_circle,
              ),
            ),
            
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    padding: const EdgeInsets.all(8),
                    child: Text(comment.getFullName())),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blue),
                    child: getCommentType(comment),
                  ),
                  Container(
                      margin: const EdgeInsets.only(bottom: 4, left: 4, top: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(comment.timestamp.getCurrentTimestamp()),
                    ),
                
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            
          ],
        ),
      ),
    );
  }
}
