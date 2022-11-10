import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';

import '../../services/network.dart';
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
  late Map<String, dynamic> data;
  late String path;
  @override
  void initState() {
    super.initState();
    data = widget.document.data() as Map<String, dynamic>;
    path = widget.document.reference.path;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        ListTile(
          leading: const Icon(
            Icons.account_circle,
            size: 60,
          ),
          title: Text(
            "${data["data"]["firstName"]} ${data["data"]["lastName"]}",
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: const Text("Has signed the lease"),
        ),
        const SizedBox(
          height: 16,
        ),
        SecondaryButton(Icons.download, "Download", (context) async {
          if (kIsWeb) {
            WebNetwork webNetwork = WebNetwork();
            String filePath =
                webNetwork.downloadFromURL(data["data"]["documentURL"]);
            webNetwork.openFile(filePath);
          } else {
            Network network = Network();
            String filePath = await network.downloadFromURL(
                data["data"]["documentURL"],
                "StandardLeaseAgreement_Ontario.pdf");
            network.openFile(filePath);
          }
        })
      ]),
    );
  }
}
