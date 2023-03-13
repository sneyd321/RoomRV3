import 'package:flutter/material.dart';
import 'package:notification_app/bloc/list/card/card_template.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/lease/landlord_info/email/card/email_card.dart';
import 'package:notification_app/lease/landlord_info/email/email_bloc.dart';
import 'package:notification_app/lease/landlord_info/email/field/email_field.dart';
import 'package:notification_app/lease/landlord_info/landlord_info_error_key.dart';
import 'package:notification_app/bloc/list/list_container.dart';

class EmailList extends ListContainer {
  @override
  void setErrorKey() {
    errorKey = LandlordInfoErrorKey.emails;
  }

  @override
  void setLabel() {
    label = "Add Email";
  }

  @override
  CardTemplate getCard(
      BuildContext context, int index, Animation<double> animation) {
    return EmailCard(
      item: bloc.getList(errorKey).elementAt(index),
      index: index,
      onUpdate: (email) {
        updateItem(email, index);
      },
      onRemove: () {
        removeItem(index);
      },
    );
  }

  @override
  void setSelectionErrorKey() {
    selectionErrorKey = LandlordInfoErrorKey.receiveDocumentsByEmail;
  }

  @override
  void setFormBuilder() {
    final EmailBloc emailBloc = EmailBloc();
    formBuilder = FormBuilder(emailBloc).add(EmailField());
  }
}
