import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/tenant.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';

class AddTenantMutation extends StatefulWidget {
  final Tenant tenant;
  final String houseKey;
  final GlobalKey<FormState> formKey;
  final Function(BuildContext context, int houseId) onComplete;
  const AddTenantMutation(
      {Key? key, required this.onComplete, required this.tenant, required this.houseKey, required this.formKey})
      : super(key: key);

  @override
  State<AddTenantMutation> createState() => _AddTenantMutationState();
}

class _AddTenantMutationState extends State<AddTenantMutation> {

  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );

  dynamic getAddHouseMutation() {
    return gql(r"""
  mutation createHouse($houseKey: ID!, $tenantInput: TenantInput!){
    addTenant(houseKey: $houseKey, tenant: $tenantInput){
      firstName,
      lastName,
      email
    }
  }
  """);
  }

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: getAddHouseMutation(),
        onCompleted: (Map<String, dynamic>? resultData) async {
          Navigator.pop(context);
        },
      ),
      builder: (runMutation, result) {
        return PrimaryButton(
          Icons.upload,
          "Invite",
          (context) async {
            if (widget.formKey.currentState!.validate()) {
              widget.formKey.currentState!.save();
               runMutation({'houseKey': widget.houseKey, 'tenantInput': widget.tenant.toJson()});
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
            }
           
          },
        );
      },
    );
  }
}
