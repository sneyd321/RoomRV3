import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:signature/signature.dart';

import '../../widgets/Buttons/SecondaryButton.dart';

class AddLeaseSigniturePage extends StatefulWidget {
  const AddLeaseSigniturePage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddLeaseSigniturePage> createState() => _AddLeaseSigniturePageState();
}

class _AddLeaseSigniturePageState extends State<AddLeaseSigniturePage> {
  final SignatureController controller =
      SignatureController(exportBackgroundColor: Colors.white);

  String signitureError = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(

              children: [
                Spacer(),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: ClipRRect(
                    child: SizedBox(
                      height: 125,
                      child: Signature(
                        controller: controller,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(signitureError,
                          style: const TextStyle(color: Colors.red))),
                ),
                SecondaryButton(Icons.clear_outlined, "Clear", (context) {
                  controller.clear();
                }),
                Spacer(),
                PrimaryButton(Icons.upload, "Create Lease", (context) {
                  
                })
              ],
            )));
  }
}
