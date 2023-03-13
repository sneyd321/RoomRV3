import 'package:flutter/material.dart';
import 'package:notification_app/bloc/helper/bottom_sheet_helper.dart';
import 'package:notification_app/buttons/IconTextColumn.dart';
import 'package:notification_app/buttons/ProfilePicture.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../../graphql/query_helper.dart';
import '../cards/AddTenantCard.dart';

class TenantRow extends StatefulWidget {
  final House house;
  const TenantRow({Key? key, required this.house}) : super(key: key);

  @override
  State<TenantRow> createState() => _TenantRowState();
}

class _TenantRowState extends State<TenantRow> {
  int counter = 0;
  bool lock = true;
  List<Tenant> tenants = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final ScrollController scrollController = ScrollController();

  void showTenantDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: AddTenantCard(
                houseKey: widget.house.houseKey,
                tenant: tenants[index],
                onDeleteTenant: () {
                  tenants.removeAt(index);
                  listKey.currentState!.removeItem(index,
                      ((context, animation) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: FadeTransition(
                          opacity:
                              animation.drive(CurveTween(curve: Curves.easeOut)),
                          child: ProfilePicture(
                            profileSize: 40,
                            iconSize: 60,
                            profileColor: Colors.blueGrey,
                            textColor: Colors.black,
                            icon: Icons.account_circle,
                            profileURL: "",
                            text: "Removing...",
                            onClick: () {},
                          )),
                    );
                  }), duration: const Duration(milliseconds: 1000));
                  Navigator.of(context).pop();
                }),
          );
        });
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
          if (tenants.isEmpty) {
            return Align(
              alignment: Alignment.centerLeft,
              child: IconTextColumn(
                  icon: Icons.add,
                  text: "Add Tenant",
                  profileSize: 40,
                  iconSize: 60,
                  profileColor: Colors.blueGrey,
                  textColor: Colors.black,
                  onClick: () async {
                    Tenant? tenant = await BottomSheetHelper<Tenant?>(Text(""))
                        .show(context);
                    if (tenant == null) {
                      return;
                    }

                    tenants.add(tenant);
                    listKey.currentState!.insertItem(tenants.length - 1);
                   

                    
                  }),
            );
          }
          counter = tenants.length;
          lock = false;
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Flexible(
              child: SizedBox(
                height: 120,
                child: AnimatedList(
                    controller: scrollController,
                    shrinkWrap: true,
                    key: listKey,
                    initialItemCount: counter,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index, animation) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: FadeTransition(
                            opacity:
                                animation.drive(CurveTween(curve: Curves.easeIn)),
                            child: ProfilePicture(
                                profileSize: 40,
                                iconSize: 60,
                                profileColor: Colors.blueGrey,
                                textColor: Colors.black,
                                icon: Icons.account_circle,
                                profileURL: tenants[index].profileURL,
                                text: tenants[index].fullName,
                                onClick: () {
                                  showTenantDialog(index);
                                })),
                      );
                    },
                  ),
                ),
              
            ),
            IconTextColumn(
                icon: Icons.add,
                text: "Add Tenant",
                profileSize: 40,
                iconSize: 60,
                profileColor: Colors.blueGrey,
                textColor: Colors.black,
                onClick: () async {
                  Tenant? tenant = await BottomSheetHelper<Tenant?>(
                          Text(""))
                      .show(context);
                  if (tenant == null) {
                    return;
                  }

                 
                    tenants.add(tenant);
                    listKey.currentState!.insertItem(tenants.length - 1);
                    
                  Future.delayed(Duration(seconds: 1), (() {
                    scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  }));
                }),
          ]);
        });
  }
}
