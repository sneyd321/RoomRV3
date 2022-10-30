import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Wrappers/ItemLists/TenantNamesList.dart';
import 'package:notification_app/widgets/mutations/tenant_name_mutation.dart';

class UpdateTenantNamesPage extends StatefulWidget {
  final Lease lease;

  final Function(BuildContext context) onUpdate;
  const UpdateTenantNamesPage(
      {Key? key,
      required this.onUpdate,
      required this.lease})
      : super(key: key);

  @override
  State<UpdateTenantNamesPage> createState() => _UpdateTenantNamesPageState();
}

class _UpdateTenantNamesPageState extends State<UpdateTenantNamesPage> {
  String errorText = "";
  bool validate() {
    widget.onUpdate(context);
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: TenantNamesList(tenantNames: widget.lease.tenantNames)),
        Container(
          margin: const EdgeInsets.only(left: 8, bottom: 8),
          alignment: Alignment.centerLeft,
          child: Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 18),)),
        UpdateTenantNameMutation(lease: widget.lease, onComplete: ((context, tenantNames) {
          
        }), validate: validate)
      ],
    );
  }
}


