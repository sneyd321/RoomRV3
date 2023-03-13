import 'package:flutter/material.dart';
import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/bloc/helper/bottom_sheet_helper.dart';
import 'package:notification_app/bloc/list/card/card_template.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/form_builder/form_container.dart';
import 'package:notification_app/lease/landlord_info/contact/contact_bloc.dart';
import 'package:notification_app/lease/landlord_info/contact/field/contact_field.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class ContactCard extends CardTemplate<Contact> {
  ContactCard(
      {required Contact item,
      required int index,
      required void Function(Contact t) onUpdate,
      required void Function() onRemove})
      : super(item: item, index: index, onUpdate: onUpdate, onRemove: onRemove);

  FormBuilder getFormBuilder(Bloc bloc) =>
      FormBuilder(bloc).add(ContactField());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.phone),
        title: GestureDetector(
            onTap: () {
              final ContactBloc contactBloc = ContactBloc();
              BottomSheetHelper(FormContainer(
                formBuilder: getFormBuilder(contactBloc),
                onUpdate: () {
                  onUpdate(contactBloc.getData());
                },
                buttonText: 'Update Contact',
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
