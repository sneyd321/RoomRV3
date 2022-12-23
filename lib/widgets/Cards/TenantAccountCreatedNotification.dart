import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/tenant.dart';

import 'AddTenantCard.dart';


class TenantAccountCreatedNotification extends StatefulWidget {
  final QueryDocumentSnapshot document;
  const TenantAccountCreatedNotification({Key? key, required this.document})
      : super(key: key);

  @override
  State<TenantAccountCreatedNotification> createState() =>
      _TenantAccountCreatedNotificationState();
}

class _TenantAccountCreatedNotificationState
    extends State<TenantAccountCreatedNotification> {

      void showTenantDialog() {
    Tenant tenant = Tenant();
    tenant.firstName = widget.document["data"]["firstName"];
    tenant.lastName = widget.document["data"]["lastName"];
    tenant.email = widget.document["data"]["email"];
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: AddTenantCard(
                houseKey: widget.document["houseKey"],
                tenant: tenant,
                isDeleteVisible: false,
                onDeleteTenant: () {
                  
                }),
          );
        });
  }
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showTenantDialog();
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: ListTile(
          visualDensity: VisualDensity(vertical: 0.5),
          leading: const CircleAvatar(child: Icon(Icons.account_circle, color: Colors.white,), backgroundColor: Colors.amber,),
          title: Text(
            "${widget.document.get("data")["firstName"]} ${widget.document.get("data")["lastName"]}",
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: const Text("Has created an account"),
          trailing: IconButton(
            onPressed: () {
              showTenantDialog();
            },
            icon: const Icon(Icons.chevron_right_rounded)),
        ),
      ),
    );
  }
}
