import 'package:flutter/material.dart';
import 'package:notification_app/widgets/buttons/ProfilePicture.dart';
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
                    return FadeTransition(
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
                        ));
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
                    Tenant? tenant = await BottomSheetHelper<Tenant?>(
                            AddTenantEmailForm(houseId: widget.house.houseId))
                        .show(context);
                    if (tenant == null) {
                      return;
                    }

                    tenants.add(tenant);
                    listKey.currentState!.insertItem(tenants.length - 1);
                    scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);

                    
                  }),
            );
          }
          counter = tenants.length;
          lock = false;
          return Row(children: [
            Flexible(
              child: SizedBox(
                height: 120,
                child: Scrollbar(
                  thumbVisibility: true,
                  scrollbarOrientation: ScrollbarOrientation.bottom,
                  controller: scrollController,
                  thickness: 10,
                  child: AnimatedList(
                    controller: scrollController,
                    shrinkWrap: true,
                    key: listKey,
                    initialItemCount: counter,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index, animation) {
                      return FadeTransition(
                          opacity:
                              animation.drive(CurveTween(curve: Curves.easeIn)),
                          child: ProfilePicture(
                              profileSize: 40,
                              iconSize: 60,
                              profileColor: Colors.blueGrey,
                              textColor: Colors.black,
                              icon: Icons.account_circle,
                              profileURL: tenants[index].profileURL,
                              text: tenants[index].getFullName(),
                              onClick: () {
                                showTenantDialog(index);
                              }));
                    },
                  ),
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
                          AddTenantEmailForm(houseId: widget.house.houseId))
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
