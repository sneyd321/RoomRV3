import 'package:flutter/material.dart';

import '../../services/network.dart';
import '../../services/notification/download_lease_notification.dart';

class DownloadLeaseNotificationCard extends StatefulWidget {
  final String documentURL;
  const DownloadLeaseNotificationCard({Key? key, required this.documentURL})
      : super(key: key);

  @override
  State<DownloadLeaseNotificationCard> createState() =>
      _DownloadLeaseNotificationCardState();
}

class _DownloadLeaseNotificationCardState
    extends State<DownloadLeaseNotificationCard> {
  DownloadLeaseNotification downloadLeaseNotification =
      DownloadLeaseNotification();

  String errorText = "";

  void onDownloadLease() async {
    if (widget.documentURL == "") {
      setState(() {
        errorText =
            "Download link is missing. Please tell landlord to re generate lease and invite again.";
      });
    }
    Network network = Network();
    downloadLeaseNotification.showNotification();
    String filePath = await network.downloadFromURL(
        widget.documentURL, "StandardLeaseAgreement_Ontario.pdf");
    await downloadLeaseNotification.localNotificationService.cancel(0);
    network.openFile(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
              alignment: Alignment.center,
              child: Text(
                "StandardLeaseAgreement_Ontario.pdf",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 16, right: 8),
            child: ElevatedButton(
                onPressed: onDownloadLease, child: const Text("Download")),
          ),
          Text(
            errorText,
            style: const TextStyle(color: Colors.red),
          )
        ],
      ),
    );
  }
}
