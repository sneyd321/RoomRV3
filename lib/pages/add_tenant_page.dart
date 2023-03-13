import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/bloc/helper/bottom_sheet_helper.dart';
import 'package:notification_app/graphql/query_helper.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class AddTenantPage extends StatefulWidget {
  final House house;
  const AddTenantPage({Key? key, required this.house}) : super(key: key);

  @override
  State<AddTenantPage> createState() => _AddTenantPageState();
}

class _AddTenantPageState extends State<AddTenantPage> {
  List<Tenant> tenants = [];

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GQLClient().getClient(),
        child: QueryHelper(
          isList: true,
          variables: {"houseId": widget.house.houseId},
          queryName: "getTenants",
          onComplete: (json) {
            if (json.length != tenants.length) {
              tenants = json
                  .map<Tenant>((tenantJson) => Tenant.fromJson(tenantJson))
                  .toList();
            }

            return SafeArea(
                child: Scaffold(
                    floatingActionButton: FloatingActionButton.extended(
                      icon: const Icon(Icons.add),
                      label: const Text("Add Tenant"),
                      onPressed: () async {
                        Tenant? tenant = await BottomSheetHelper<Tenant?>(
                                Text(""))
                            .show(context);
                        if (tenant == null) {
                          return;
                        }
                        tenants.add(tenant);

                        setState(() {});
                      },
                    ),
                    appBar: AppBar(
                      title: Text("Add Tenant"),
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    body: tenants.isNotEmpty
                        ? null
                        : const Card(
                            margin: EdgeInsets.all(8),
                            child: ListTile(
                              title: Text("No Tenants"),
                            ),
                          )));
          },
        ));
  }
}
