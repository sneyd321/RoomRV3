import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/graphql/query_helper.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Cards/AddTenantCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddTenantForm.dart';
import 'package:notification_app/widgets/Helper/BottomSheetHelper.dart';

import '../business_logic/tenant.dart';
import '../widgets/Listviews/CardSliverGridView.dart';

class AddTenantPage extends StatefulWidget {
  final House house;
  const AddTenantPage({Key? key, required this.house}) : super(key: key);

  @override
  State<AddTenantPage> createState() => _AddTenantPageState();
}

class _AddTenantPageState extends State<AddTenantPage> {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GQLClient().getClient(),
        child: QueryHelper(
          isList: true,
          variables: {"houseId": widget.house.houseId},
          queryName: "getTenants",
          onComplete: (json) {
            json = json as List<dynamic>;
            List<Tenant> tenants = json
                .map<Tenant>((tenantJson) => Tenant.fromJson(tenantJson))
                .toList();
  
            return SafeArea(
                child: Scaffold(
                    floatingActionButton: FloatingActionButton.extended(
                      icon: const Icon(Icons.add),
                      label: const Text("Add Tenant"),
                      onPressed: () async {
                        Tenant? tenant = await BottomSheetHelper<Tenant?>(
                                AddTenantEmailForm(houseId: widget.house.houseId))
                            .show(context);
                        if (tenant == null) {
                          return;
                        }
                        tenants.add(tenant);

                        setState(() {
                          
                        });
                        
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
                    body: CardSliverGridView(
                      childAspectRatio: .91,
                      builder: (context, index) {
                        Tenant tenant = tenants[index];
                        return AddTenantCard(
                            tenant: tenant, houseKey: widget.house.houseKey);
                      },
                      items: tenants,
                    )));
          },
        ));
  }
}
