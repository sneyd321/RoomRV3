import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/fields/date.dart';
import 'package:notification_app/business_logic/partial_period.dart';
import 'package:notification_app/business_logic/rental_period.dart';
import 'package:notification_app/business_logic/tenancy_terms.dart';
import 'package:notification_app/widgets/Forms/FormRow/HalfRow.dart';


import '../../buttons/SecondaryButton.dart';
import '../../Cards/PartialPeriodCard.dart';
import '../../FormFields/SimpleDatePicker.dart';
import '../../FormFields/SimpleRadioGroup.dart';
import '../../Helper/BottomSheetHelper.dart';
import '../../Helper/TextHelper.dart';
import '../BottomSheetForm/PartialRentForm.dart';

class TenancyTermsForm extends StatefulWidget {
  final TenancyTerms tenancyTerms;
  final GlobalKey<FormState> formKey;

  const TenancyTermsForm(
      {Key? key, required this.tenancyTerms, required this.formKey})
      : super(key: key);

  @override
  State<TenancyTermsForm> createState() => _TenancyTermsFormState();
}

class _TenancyTermsFormState extends State<TenancyTermsForm> {
  final TextEditingController startDateTextEditingController =
      TextEditingController();
  final TextEditingController endDateTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    startDateTextEditingController.text = widget.tenancyTerms.startDate;
    endDateTextEditingController.text =
        widget.tenancyTerms.rentalPeriod.endDate;
  }

  @override
  void dispose() {
    super.dispose();
    startDateTextEditingController.dispose();
    endDateTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(children: [
        const TextHelper(text: "Rent is to be paid on:"),
        Container(
          margin: const EdgeInsets.all(8),
          child: SimpleRadioGroup(
            names: const ["First", "Second", "Last"],
            radioGroup: widget.tenancyTerms.rentDueDate,
            onSelected: (context, value) {
              setState(() {
                if (widget.tenancyTerms.paymentPeriod == "Day") {
                  widget.tenancyTerms.setRentDueDate("First");
                  return;
                }
                widget.tenancyTerms.setRentDueDate(value!);
              });
            },
            isHorizontal: true,
          ),
        ),
        const TextHelper(text: "Day of each:"),
        Container(
          margin: const EdgeInsets.all(8),
          child: SimpleRadioGroup(
            radioGroup: widget.tenancyTerms.paymentPeriod,
            names: const ["Month", "Week", "Day"],
            onSelected: (context, value) {
              setState(() {
                if (value == "Day") {
                  widget.tenancyTerms.setRentDueDate("First");
                }
                widget.tenancyTerms.setPaymentPeriod(value!);
              });
            },
            isHorizontal: true,
          ),
        ),
        const TextHelper(text: "This tenancy starts on:"),
        Row(
          children: [
            Expanded(
                child: Container(
              margin: const EdgeInsets.all(8),
              child: SimpleDatePicker(
                textEditingController: startDateTextEditingController,
                label: 'Start Date',
                onSaved: (String? value) {
                  widget.tenancyTerms.setStartDate(value!);
                },
                onValidate: (String? value) {
                  return StartDate(value!).validate();
                },
              ),
            )),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Visibility(
                  visible: widget.tenancyTerms.rentalPeriod.rentalPeriod ==
                      "Fixed Term",
                  child: SimpleDatePicker(
                    textEditingController: endDateTextEditingController,
                    label: "End Date",
                    onSaved: (String? value) {
                      RentalPeriod rentalPeriod = RentalPeriod("Fixed Term");
                      rentalPeriod.endDate = value!;
                      widget.tenancyTerms.setRentalPeriod(rentalPeriod);
                    },
                    onValidate: (String? value) {
                      return EndDate(value).validate();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const TextHelper(text: "This tenancy agreement is for:"),
        Container(
          margin: const EdgeInsets.all(8),
          child: RadioListTile(
              contentPadding: const EdgeInsets.all(0),
              title: const Text("Fixed Term"),
              value: "Fixed Term",
              groupValue: widget.tenancyTerms.rentalPeriod.rentalPeriod,
              onChanged: (String? value) {
                setState(() {
                  RentalPeriod rentalPeriod = RentalPeriod(value!);
                  widget.tenancyTerms.setRentalPeriod(rentalPeriod);
                });
              }),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: SimpleRadioGroup(
              radioGroup: widget.tenancyTerms.rentalPeriod.rentalPeriod,
              names: const ["Month to Month", "Week to Week", "Day to Day"],
              onSelected: (context, value) {
                setState(() {
                  RentalPeriod rentalPeriod = RentalPeriod(value!);
                  widget.tenancyTerms.setRentalPeriod(rentalPeriod);
                });
              },
              isHorizontal: true),
        ),
        PartialPeriodCard(partialPeriod: widget.tenancyTerms.partialPeriod),
        HalfRow(
          child: SecondaryButton(Icons.add, "Partial Period", (context) {
            BottomSheetHelper(PartialRentForm(
                onSave: (BuildContext context, PartialPeriod partialPeriod) {
              setState(() {
                partialPeriod.setEnabled(true);
                widget.tenancyTerms.setPartialPeriod(partialPeriod);
              });
            })).show(context);
          }),
        ),
      ]),
    );
  }
}
