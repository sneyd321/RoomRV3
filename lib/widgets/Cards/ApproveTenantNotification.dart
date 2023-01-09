import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/services/network.dart';
import 'package:notification_app/widgets/buttons/CallToActionButton.dart';

import '../../services/web_network.dart';

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
  

  void onDownloadLease() async {
    if (widget.document.get("data")["documentURL"] == "") {
      setState(() {
        errorText =
            "Download link is missing. Please tell landlord to re generate lease and invite again.";
      });
    }
    if (kIsWeb) {
      WebNetwork webNetwork = WebNetwork();
      String filePath = webNetwork.downloadFromURL(widget.document.get("data")["documentURL"]);
      webNetwork.openFile(filePath);
    } else {
      Network network = Network();
      String filePath =
          await network.downloadFromURL(widget.document.get("data")["documentURL"], "Standard_Lease_Agreement.pdf");
      network.openFile(filePath);
    }
  }

  void showNotificationDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
           
              
            content: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 8),
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
                            child: CallToActionButton(
                              text: "Download",
                              onClick: () {
                                onDownloadLease();
                              },
                            )),
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
            trailing: IconButton(
              onPressed: () {
                showNotificationDialog();
              },
              icon: const Icon(Icons.chevron_right_rounded))),
      ),
    );
  }
}
