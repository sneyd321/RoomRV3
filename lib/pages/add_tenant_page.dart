import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/list_items/tenant_name.dart';
import 'package:notification_app/business_logic/tenant.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Cards/AddTenantCard.dart';
import 'package:notification_app/widgets/Listviews/CardSliverListView.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/TenantList.dart';

class AddTenantPage extends StatelessWidget {
  final House house;
  const AddTenantPage({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Add Tenant"),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    
                  },
                )
              ],
            ),
            body: TenantList(
                house: house,
                tenants: house.lease.tenantNames
                    .map((TenantName tenantName) =>
                        Tenant.fromTenantName(tenantName))
                    .toList())));
  }
}
