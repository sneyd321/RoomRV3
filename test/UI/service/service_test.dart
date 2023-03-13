import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/bloc_card/Cards/DetailCard.dart';
import 'package:notification_app/bloc_card/Cards/RentServiceCard.dart';
import 'package:notification_app/bloc_card/FormFields/PaymentPeriodRadioGroup.dart';
import 'package:notification_app/bloc_card/FormFields/RentDueDateRadioGroup.dart';
import 'package:notification_app/bloc_card/FormFields/RentalPeriodRadioGroup.dart';
import 'package:notification_app/bloc_card/FormFields/SimpleDatePicker.dart';
import 'package:notification_app/bloc_card/FormFields/SimpleFormField.dart';
import 'package:notification_app/bloc_card/FormFields/SimpleRadioGroup.dart';
import 'package:notification_app/bloc_card/Wrappers/ItemLists/PaymentOptionsList.dart';
import 'package:notification_app/bloc_card/Wrappers/ItemLists/RentServicesList.dart';
import 'package:notification_app/bloc_card/Wrappers/ItemLists/ServiceDetailsList.dart';
import 'package:notification_app/bloc_card/buttons/CallToActionButton.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

void main() {
  Widget getForm(Widget formField) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            children: [
              formField,
              CallToActionButton(
                  text: "Test",
                  onClick: () {
                    formKey.currentState!.validate();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addItemToList(WidgetTester tester, String name,
      [String addButtonText = "Add",
      String bottomSheetButtonText = "Add"]) async {
    await tester.tap(find.textContaining(addButtonText));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), name);
    await tester.pumpAndSettle();
    await tester.tap(find.text(bottomSheetButtonText));
    await tester.pumpAndSettle();
  }

  Future<void> submit(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(SimpleFormField), text);
    await tester.pump();
    await tester.tap(find.text("Test"));
    await tester.pump();
  }

  testWidgets("name_IS_UPDATED_WHEN_Service_IS_Updated", (tester) async {
    Service service = CustomService("");
    Widget formField = SimpleFormField(
      icon: Icons.abc,
      label: 'Service Name',
      onSaved: (String? value) {},
      onValidate: (String? value) {
        return service.updateName(value!);
      },
      textEditingController: TextEditingController(),
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "Example");
    expect(service.name, "Example");

  });

  testWidgets("List_of_Detail_IS_UPDATED_WHEN_Detail_IS_Added",
      (tester) async {
    Service service = CustomService("");
    await tester.pumpWidget(getForm(ServiceDetailsList(service: service)));
    await addItemToList(tester, "asdf");
    expect(find.byType(DetailCard), findsOneWidget);
  });

  testWidgets("List_of_Detail_IS_UPDATED_WHEN_Detail_IS_Removed",
      (tester) async {
    Service service = CustomService("");
    await tester.pumpWidget(getForm(ServiceDetailsList(service: service)));
    await addItemToList(tester, "asdf");
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(find.byType(DetailCard), findsNothing);
  });

  testWidgets("Please_enter_a_name_IS_RETURNED_WHEN_Service_IS_Error-Invalid_Request", (tester) async {
    Service service = CustomService("");
    Widget formField = SimpleFormField(
      icon: Icons.abc,
      label: 'Service Name',
      onSaved: (String? value) {},
      onValidate: (String? value) {
        return service.updateName(value!);
      },
      textEditingController: TextEditingController(),
    );
    await tester.pumpWidget(getForm(formField));
    await submit(tester, "");
    expect(find.text("Please enter a name."), findsOneWidget);

  });

  testWidgets("Detail_already_exists_IS_RETURNED_WHEN_List_of_Detail_IS_Error-Resource_Exists",
      (tester) async {
    Service service = CustomService("");
    await tester.pumpWidget(getForm(ServiceDetailsList(service: service)));
    await addItemToList(tester, "asdf");
    await addItemToList(tester, "asdf");
    expect(find.text("Error asdf already exists."), findsOneWidget);
  });

    testWidgets("Detail_already_exists_IS_RETURNED_WHEN_List_of_Detail_IS_Error-Resource_Exists",
      (tester) async {
    Service service = CustomService("");
    await tester.pumpWidget(getForm(ServiceDetailsList(service: service)));
    await addItemToList(tester, "asdf");
    await addItemToList(tester, "asdf");
    expect(service.details.length, 1);
  });


}
