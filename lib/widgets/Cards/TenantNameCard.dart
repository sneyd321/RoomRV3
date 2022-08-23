import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';

import '../../business_logic/list_items/tenant_name.dart';
import '../Helper/TextHelper.dart';


class TenantNameCard extends StatelessWidget {
  final TenantName tenantName;
  final Function(BuildContext context, TenantName tenantName) onItemRemoved;

  const TenantNameCard({Key? key, required this.tenantName, required this.onItemRemoved}) : super(key: key);

  

 
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: TextHelper(text: tenantName.name),
            trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            onItemRemoved(context, tenantName);
          },
        ),
          ),
        ],
      ),
    );
  }


}