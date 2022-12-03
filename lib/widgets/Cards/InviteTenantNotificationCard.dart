import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/UpdateTenantEmailForm.dart';
import 'package:notification_app/widgets/Helper/BottomSheetHelper.dart';

class InviteTenantNotificationCard extends StatefulWidget {
  final QueryDocumentSnapshot document;

  const InviteTenantNotificationCard({Key? key, required this.document})
      : super(key: key);

  @override
  State<InviteTenantNotificationCard> createState() =>
      _InviteTenantNotificationCardState();
}

class _InviteTenantNotificationCardState
    extends State<InviteTenantNotificationCard> {
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
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          visualDensity: VisualDensity(vertical: 0.5),
          isThreeLine: true,
          leading: const CircleAvatar(child: Icon(Icons.account_circle)),
          title: Text("${data['firstName']} ${data['lastName']}"),
          subtitle: const Text("Has signed the lease"),
          trailing: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(25)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(color: Colors.black)))),
                onPressed: () async {
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
                              children: [Text("data")],
                            ),
                          ),
                        );
                      });
                },
                child: const Text(
                  "View Details",
                  style: TextStyle(fontSize: 16),
                )),
          ),
        )
      ]),
    );
  }
}
