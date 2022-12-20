import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

class ApproveTenantNotificationCard extends StatefulWidget {
  final QueryDocumentSnapshot document;
  const ApproveTenantNotificationCard({Key? key, required this.document})
      : super(key: key);

  @override
  State<ApproveTenantNotificationCard> createState() =>
      _ApproveTenantNotificationCardState();
}

class _ApproveTenantNotificationCardState
    extends State<ApproveTenantNotificationCard> {
  String errorText = "";

  void showNotificationDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 75,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              alignment: Alignment.center,
                              child: const Text(
                                "Standard_Lease_Agreement.pdf",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 16, bottom: 16, right: 8),
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text("Download")),
                        ),
                        Text(
                          errorText,
                          style: const TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showNotificationDialog();
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: ListTile(
            visualDensity: VisualDensity(vertical: 0.5),
            leading: const CircleAvatar(
                backgroundColor: Colors.amber,
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                )),
            title: Text(
              "${widget.document.get("sender")["firstName"]} ${widget.document.get("sender")["lastName"]}",
              style: const TextStyle(fontSize: 16),
            ),
            subtitle: const Text("Has signed the lease"),
            trailing: const Icon(Icons.chevron_right_rounded)),
      ),
    );
  }
}
