import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/widgets/Cards/AddTenantCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemStateWrapper.dart';

import '../../../business_logic/tenant.dart';

class TenantList extends StatefulWidget {
  final List<Tenant> tenants;
  final House house;
  const TenantList({Key? key, required this.tenants, required this.house}) : super(key: key);

  @override
  State<TenantList> createState() => _TenantListState();
}

class _TenantListState extends State<TenantList> {
  

  @override
  Widget build(BuildContext context) {
    return SliverAddItemStateWrapper(items: widget.tenants, builder: (context, index) {
      Tenant tenant = widget.tenants[index];
      return AddTenantCard(tenant: tenant, houseKey: widget.house.houseKey,);
    }, form: AddNameForm(onSave: (context, name) {
      setState(() {
        //widget.tenants.add(Tenant.fromTenantName(TenantName(name)));
      });
    }, names: const []), scrollController: ScrollController());
  }
}