import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/widgets/Buttons/IconTextColumn.dart';

import '../../business_logic/house.dart';
import '../../business_logic/tenant.dart';
import '../../graphql/query_helper.dart';
import '../Cards/AddTenantCard.dart';
import '../Forms/BottomSheetForm/AddTenantForm.dart';
import '../Helper/BottomSheetHelper.dart';

class TenantRow extends StatefulWidget {
  final House house;
  const TenantRow({Key? key, required this.house}) : super(key: key);

  @override
  State<TenantRow> createState() => _TenantRowState();
}

class _TenantRowState extends State<TenantRow> {
  List<Tenant> tenants = [];
  bool lock = true;

  void addTenantButton(List<Widget> tenantWidgets) {
    tenantWidgets.add(IconTextColumn(
        icon: Icons.add,
        text: "Add Tenant",
        profileSize: 40,
        iconSize: 60,
        profileColor: Colors.blueGrey,
        textColor: Colors.black,
        onClick: () async {
          Tenant? tenant = await BottomSheetHelper<Tenant?>(
                  AddTenantEmailForm(houseId: widget.house.houseId))
              .show(context);
          if (tenant == null) {
            return;
          }

          setState(() {
            tenants.add(tenant);
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return QueryHelper(
        isList: true,
        variables: {"houseId": widget.house.houseId},
        queryName: "getTenants",
        onComplete: (json) {
          if (lock) {
            tenants = json
                .map<Tenant>((tenantJson) => Tenant.fromJson(tenantJson))
                .toList();
            lock = false;
          }

          List<Widget> tenantWidgets = [];
          tenantWidgets = tenants.map<Widget>((tenant) {
            return IconTextColumn(
              profileSize: 40,
              iconSize: 60,
              profileColor: Colors.blueGrey,
              textColor: Colors.black,
              icon: Icons.account_circle,
              text: tenant.getFullName(),
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: AddTenantCard(
                            houseKey: widget.house.houseKey,
                            tenant: tenant,
                            onDeleteTenant: (tenant) {
                              setState(() {
                                tenants.remove(tenant);
                              });
                            }),
                      );
                    });
              },
            );
          }).toList();
          addTenantButton(tenantWidgets);
          return Wrap(
              children: tenantWidgets,
          );
          
        });
  }
}
