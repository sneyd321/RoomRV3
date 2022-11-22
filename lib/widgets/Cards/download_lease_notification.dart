import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/services/FirebaseConfig.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:signature/signature.dart';
import 'package:universal_html/html.dart';

import '../../services/network.dart';
import '../../services/notification/download_lease_notification.dart';
import '../../services/web_network.dart';

class DownloadLeaseNotificationCard extends StatefulWidget {
  final QueryDocumentSnapshot document;
  
  const DownloadLeaseNotificationCard({Key? key, required this.document})
      : super(key: key);

  @override
  State<DownloadLeaseNotificationCard> createState() =>
      _DownloadLeaseNotificationCardState();
}

class _DownloadLeaseNotificationCardState
    extends State<DownloadLeaseNotificationCard> {
  DownloadLeaseNotification downloadLeaseNotification =
      DownloadLeaseNotification();
  final SignatureController controller =
      SignatureController(exportBackgroundColor: Colors.white);
  String signitureError = "";

  String errorText = "";

  late String documentURL;
  late String houseKey;
  late String documentName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    documentURL = widget.document.get("data")["documentURL"];
    houseKey = widget.document.get("houseKey");
    documentName = "StandardLeaseAgreement_Ontario.pdf"; 

  }

  void onDownloadLease() async {
    if (documentURL == "") {
      setState(() {
        errorText =
            "Download link is missing. Please tell landlord to re generate lease and invite again.";
      });
    }
    if (kIsWeb) {
      WebNetwork webNetwork = WebNetwork();
      String filePath = webNetwork.downloadFromURL(documentURL);
      await downloadLeaseNotification.localNotificationService.cancel(0);
      webNetwork.openFile(filePath);
    } else {
      Network network = Network();
      String filePath = await network.downloadFromURL(
          documentURL, documentName);
      await downloadLeaseNotification.localNotificationService.cancel(0);
      network.openFile(filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: MutationHelper(
        builder: (runMutation) {
          return Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {
                      widget.document.reference.delete();
                    }, icon: const Icon(Icons.close))
                  ],
                ),
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
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            documentName,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                      const Spacer(),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 16, bottom: 16, right: 8),
                        child: ElevatedButton(
                            onPressed: onDownloadLease,
                            child: const Text("Download")),
                      ),
                      Text(
                        errorText,
                        style: const TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                SecondaryButton(Icons.pin_end, "Sign Lease", (context) {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            TextButton(
                              child: const Text('Clear'),
                              onPressed: () {
                                controller.clear();
                              },
                            ),
                            TextButton(
                              child: const Text('Generate'),
                              onPressed: () async {
                                if (controller.isEmpty) {
                                  setState(() {
                                    signitureError = "Please enter a signature";
                                  });
                                }
                                String base64EncodedSigniture = base64Encode(
                                    await controller.toPngBytes() ?? []);
                                runMutation({
                                  "signature": base64EncodedSigniture,
                                  "houseKey": houseKey
                                });
                                Navigator.pop(context);
                              },
                            )
                          ],
                          content: Container(
                            constraints: const BoxConstraints(maxWidth: 400),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  child: ClipRRect(
                                    child: SizedBox(
                                      height: 125,
                                      child: Signature(
                                        controller: controller,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(signitureError,
                                          style: const TextStyle(
                                              color: Colors.red))),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
              ],
            ),
          );
        },
        mutationName: 'scheduleLease',
        onComplete: (json) {},
      ),
    );
  }
}
