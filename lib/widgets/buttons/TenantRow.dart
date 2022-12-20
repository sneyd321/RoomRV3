import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Buttons/ProfilePicture.dart';
import 'package:notification_app/widgets/buttons/IconTextColumn.dart';

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
  List<Widget> tenantWidgets = [];

  //Hack solution: setState keeps fetching from the DB for the latest changes but gets called too fast
  bool lock = true;

  @override
  void initState() {
    super.initState();
    lock = true;
  }

  void showTenantDialog(Tenant tenant) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: AddTenantCard(
                houseKey: widget.house.houseKey,
                tenant: tenant,
                onDeleteTenant: (tenantToBeDeleted) {
                  setState(() {
                    tenants.remove(tenantToBeDeleted);
                    tenantWidgets = [];
                    objectsToWidgets(tenants);
                    appendAddTenantButton();
                    lock = false;
                  });
                }),
          );
        });
  }

  List<Widget> objectsToWidgets(List<Tenant> tenants) {
    for (Tenant tenant in tenants) {
      tenantWidgets.add(ProfilePicture(
        profileSize: 40,
        iconSize: 60,
        profileColor: Colors.blueGrey,
        textColor: Colors.black,
        icon: Icons.account_circle,
        profileURL: tenant.profileURL,
        text: tenant.getFullName(),
        onClick: () {
          showTenantDialog(tenant);
        },
      ));
    }
    //Add tenant button

    return tenantWidgets;
  }

  void appendAddTenantButton() {
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
            tenantWidgets = [];
            objectsToWidgets(tenants);
            appendAddTenantButton();
            lock = false;
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
          }

          tenantWidgets = [];
          objectsToWidgets(tenants);
          appendAddTenantButton();

          return Container(
            margin: const EdgeInsets.all(8),
            child: Wrap(
              children: tenantWidgets,
            ),
          );
        });
  }
}
