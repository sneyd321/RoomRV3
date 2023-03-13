import 'package:flutter/material.dart';
import 'package:notification_app/bloc/helper/SecondaryActionButton.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


class UpdateServicesPage extends StatefulWidget {
  final Lease lease;

  const UpdateServicesPage({Key? key, required this.lease}) : super(key: key);

  @override
  State<UpdateServicesPage> createState() => _UpdateServicesPageState();
}

class _UpdateServicesPageState extends State<UpdateServicesPage> {
  @override
  Widget build(BuildContext context) {
    return MutationHelper(
        mutationName: "updateServices",
        onComplete: ((json) {}),
        builder: (runMutation) {
          return Column(
            children: [
              
              Container(
                  margin: const EdgeInsets.only(left: 8, bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "errorText",
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  )),
              Container(
                margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: SecondaryActionButton(
                    text: "Update",
                    onClick: () {
                      runMutation({
                        "houseId": widget.lease.houseId,
                        "services": widget.lease.services
                            .map((service) => service.toServiceInput())
                            .toList()
                      });
                    }),
              )
            ],
          );
        });
  }
}
