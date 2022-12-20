import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/tenant.dart';

import 'AddTenantCard.dart';

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

  void showTenantDialog() {
    Tenant tenant = Tenant();
    tenant.firstName = widget.document["sender"]["firstName"];
    tenant.lastName = widget.document["sender"]["lastName"];
    tenant.email = widget.document["sender"]["email"];
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: AddTenantCard(
                houseKey: widget.document["houseKey"],
                tenant: tenant,
                isDeleteVisible: false,
                onDeleteTenant: (tenantToBeDeleted) {
                  
                }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        GestureDetector(
          onTap: () {
            showTenantDialog();
          },
          child: ListTile(
            visualDensity: VisualDensity(vertical: 0.5),
            leading: const CircleAvatar(
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              backgroundColor: Colors.amber,
            ),
            title: Text("${widget.document["title"]}"),
            subtitle: Text("${widget.document["body"]}"),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right_rounded),
              onPressed: (() {
                showTenantDialog();
              }),
            ),
          ),
        ),
      ]),
    );
  }
}
