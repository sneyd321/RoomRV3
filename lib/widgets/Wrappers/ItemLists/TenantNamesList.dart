import 'package:flutter/cupertino.dart';
import 'package:notification_app/widgets/Cards/TenantNameCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:notification_app/widgets/Listviews/CardSliverGenerator.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemStateWrapper.dart';

import '../../../business_logic/list_items/tenant_name.dart';

class TenantNamesList extends StatefulWidget {
  final List<TenantName> tenantNames;
  
  const TenantNamesList({Key? key, required this.tenantNames}) : super(key: key);

  @override
  State<TenantNamesList> createState() => _TenantNamesListState();
}

class _TenantNamesListState extends State<TenantNamesList> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SliverAddItemStateWrapper(items: widget.tenantNames, builder: (context, index) {
      TenantName tenantName = widget.tenantNames[index];
      return TenantNameCard(tenantName: tenantName, onItemRemoved: (BuildContext context, TenantName tenantName) {  
        setState(() {
          widget.tenantNames.remove(tenantName);
        });
      },);
    }, 
    addButtonTitle: "Add Name",
    noItemsText: "No Tenants",
    form: AddNameForm(names: [], onSave: (context, name) {
      setState(() {
        if (widget.tenantNames.isNotEmpty) {
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
        widget.tenantNames.add(TenantName(name));
      });
    },), scrollController: scrollController,);
  }
}