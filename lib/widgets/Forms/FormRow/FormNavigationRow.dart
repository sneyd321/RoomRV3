import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Forms/FormRow/TwoColumnRow.dart';

class FormNavigationRow extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String route;

  const FormNavigationRow({Key? key, required this.formKey, required this.route}) : super(key: key);

  @override
  State<FormNavigationRow> createState() => _FormNavigationRowState();
}

class _FormNavigationRowState extends State<FormNavigationRow> {

  void onNext(BuildContext context) {
    if (widget.formKey.currentState!.validate()) {
      widget.formKey.currentState!.save();
      Navigator.of(context).pushNamed(widget.route);
    }
  }

  void onBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 8),
      child: TwoColumnRow(
                          left: SecondaryButton(Icons.chevron_left, "Back", onBack),
                          right: PrimaryButton(Icons.chevron_right, "Next", onNext)),
    );
  }
}