import 'package:flutter/material.dart';
import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/bloc/helper/bottom_sheet_helper.dart';
import 'package:notification_app/bloc/list/card/card_template.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/form_builder/form_container.dart';
import 'package:notification_app/lease/landlord_info/email/email_bloc.dart';
import 'package:notification_app/lease/landlord_info/email/field/email_field.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class EmailCard extends CardTemplate<Email> {
  EmailCard(
      {required Email item,
      required int index,
      required void Function(Email t) onUpdate,
      required void Function() onRemove})
      : super(item: item, index: index, onUpdate: onUpdate, onRemove: onRemove);

  FormBuilder getFormBuilder(Bloc bloc) => FormBuilder(bloc).add(EmailField());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.email),
        title: GestureDetector(
            onTap: () {
              final EmailBloc emailBloc = EmailBloc();
              BottomSheetHelper(FormContainer(
                formBuilder: getFormBuilder(emailBloc),
                onUpdate: () {
                  onUpdate(emailBloc.getData());
                },
                buttonText: 'Update Email',
              )).show(context);
            },
            child: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        trailing:
            IconButton(icon: const Icon(Icons.close), onPressed: onRemove),
      ),
    );
  }
}
