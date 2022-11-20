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
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  widget.document.reference.delete();
                },
                icon: const Icon(Icons.close))
          ],
        ),
        ListTile(
          leading: const Icon(
            Icons.account_circle,
            size: 60,
          ),
          title: Text(
            "${data["data"]["firstName"]} ${data["data"]["lastName"]}",
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: Text(data["data"]["email"]),
        ),
        const SizedBox(
          height: 16,
        ),
        SecondaryButton(Icons.email, "Re Send Invite", (context) {
          BottomSheetHelper(UpdateTenantEmailForm(
            names: [data["data"]["email"]],
            onSave: (context, email) {
              widget.document.reference.delete();
            },
            firstName: data["data"]["firstName"],
            houseKey: data["houseKey"],
            lastName: data["data"]["lastName"],
          )).show(context);
        })
      ]),
    );
  }
}
