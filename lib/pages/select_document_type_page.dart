import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/pages/add_lease_view_pager.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';

import '../widgets/Buttons/SecondaryButton.dart';

class SelectDocumentTypePage extends StatefulWidget {
  const SelectDocumentTypePage({Key? key}) : super(key: key);

  @override
  State<SelectDocumentTypePage> createState() => _SelectDocumentTypePageState();
}

class _SelectDocumentTypePageState extends State<SelectDocumentTypePage> {
  List<String> provinces = ["Ontario"];
  List<String> documents = ["Standard Lease Agreement"];
  late String province;
  late String document;
  @override
  void initState() {
    super.initState();
    province = provinces.first;
    document = documents.first;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Select Document")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              child: const Text(
                "Province:",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: DropdownButton<String>(
                isDense: true,
                isExpanded: true,
                value: province,
                itemHeight: 60,
                icon: const Icon(Icons.arrow_downward_rounded),
                style: const TextStyle(fontSize: 16),
                onChanged: (String? value) {
                  setState(() {
                    province = value!;
                  });
                },
                items: provinces.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: const Text(
                "Document:",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(10),
                isDense: true,
                isExpanded: true,
                value: document,
                icon: const Icon(Icons.arrow_downward_rounded),
                elevation: 16,
                style: const TextStyle(fontSize: 16),
                onChanged: (String? value) {
                  setState(() {
                    document = value!;
                  });
                },
                items: documents.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Spacer(),
            TwoColumnRow(
                left: SecondaryButton(Icons.chevron_left, "Back", ((context) {
                  Navigator.pop(context);
                })),
                right: PrimaryButton(Icons.chevron_right_outlined, "Next",
                    (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddLeaseViewPager()),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
