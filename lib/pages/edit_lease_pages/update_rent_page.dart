import 'package:flutter/material.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class UpdateRentPage extends StatefulWidget {
  final Lease lease;
  const UpdateRentPage({Key? key, required this.lease}) : super(key: key);

  @override
  State<UpdateRentPage> createState() => _UpdateRentPageState();
}

class _UpdateRentPageState extends State<UpdateRentPage> {
  @override
  Widget build(BuildContext context) {
    return MutationHelper(
        mutationName: "updateRent",
        onComplete: ((json) {}),
        builder: (runMutation) {
          return Text("data");

        });
  }
}
