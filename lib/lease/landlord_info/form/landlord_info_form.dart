import 'package:flutter/material.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/lease/landlord_info/form/field/full_name_field.dart';
import 'package:notification_app/lease/landlord_info/form/list/contact_list.dart';
import 'package:notification_app/lease/landlord_info/form/list/email_list.dart';
import 'package:notification_app/lease/landlord_info/form/selection/contact_info_selection.dart';
import 'package:notification_app/lease/landlord_info/form/selection/recieve_documents_by_email_selection.dart';
import 'package:notification_app/bloc/form_builder/form_container.dart';
import 'package:notification_app/lease/landlord_info/landlord_info_bloc.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class LandlordInfoForm extends StatefulWidget {
  final Lease lease;
  final void Function(LandlordInfo landlordInfo) onUpdate;

  const LandlordInfoForm({
    Key? key,
    required this.onUpdate,
    required this.lease,
  }) : super(key: key);

  @override
  State<LandlordInfoForm> createState() => _LandlordInfoFormState();
}

class _LandlordInfoFormState extends State<LandlordInfoForm>
    with TickerProviderStateMixin {
  late LandlordInfoBloc landlordInfoBloc;
  late FormBuilder formBuilder;

  @override
  void initState() {
    super.initState();
    landlordInfoBloc = LandlordInfoBloc.fromLease(widget.lease);
    formBuilder = FormBuilder(landlordInfoBloc, tickerProvider: this)
      .add(FullNameField())
      .add(ReceiveDocumentsByEmailSelection())
      .add(EmailList())
      .add(ContactInfoSelection())
      .add(ContactList());
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      onUpdate: () {
        widget.onUpdate(landlordInfoBloc.getData());
      },
      formBuilder: formBuilder,
      buttonText: 'Update Landlord Info',
    );
  }
}
