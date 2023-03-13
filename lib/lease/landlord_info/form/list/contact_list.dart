import 'package:flutter/cupertino.dart';
import 'package:notification_app/bloc/list/card/card_template.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/lease/landlord_info/contact/card/contact_card.dart';
import 'package:notification_app/lease/landlord_info/contact/contact_bloc.dart';
import 'package:notification_app/lease/landlord_info/contact/field/contact_field.dart';
import 'package:notification_app/lease/landlord_info/landlord_info_error_key.dart';
import 'package:notification_app/bloc/list/list_container.dart';

class ContactList extends ListContainer {
  @override
  void setErrorKey() {
    errorKey = LandlordInfoErrorKey.contacts;
  }

  @override
  void setLabel() {
    label = "Add Contact";
  }

  @override
  CardTemplate getCard(
      BuildContext context, int index, Animation<double> animation) {
    return ContactCard(
        item: bloc.getList(errorKey).elementAt(index),
        index: index,
        onUpdate: ((contact) {
          updateItem(contact, index);
        }),
        onRemove: (() {
          removeItem(index);
        }));
  }

  @override
  void setSelectionErrorKey() {
    selectionErrorKey = LandlordInfoErrorKey.contactInfo;
  }

  @override
  void setFormBuilder() {
    final ContactBloc contactBloc = ContactBloc();
    formBuilder = FormBuilder(contactBloc).add(ContactField());
  }
}
