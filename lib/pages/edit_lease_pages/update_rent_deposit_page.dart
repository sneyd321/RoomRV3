import 'package:flutter/material.dart';
import 'package:notification_app/bloc/helper/SecondaryActionButton.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../../graphql/mutation_helper.dart';

class UpdateRentDepositPage extends StatefulWidget {
  final Lease lease;

  const UpdateRentDepositPage({Key? key, required this.lease})
      : super(key: key);

  @override
  State<UpdateRentDepositPage> createState() => _UpdateRentDepositPageState();
}

class _UpdateRentDepositPageState extends State<UpdateRentDepositPage> {
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return MutationHelper(
        mutationName: "updateRentDeposits",
        onComplete: ((json) {}),
        builder: (runMutation) {
          return Column(
            children: [
             
              Container(
                  margin: const EdgeInsets.only(left: 8, bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    errorText,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  )),
              Container(
                margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: SecondaryActionButton(
                    text: "Update Rent Deposits",
                    onClick: () {
                      runMutation({
                        "houseId": widget.lease.houseId,
                        "rentDeposits": widget.lease.rentDeposits
                            .map((rentDeposit) => rentDeposit.toDepostInput())
                            .toList()
                      });
                    }),
              )
            ],
          );
        });
  }
}
