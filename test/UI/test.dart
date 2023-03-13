import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/bloc/landlord_info/landlord_info_bloc.dart';
import 'package:notification_app/bloc/rental_address/rental_address_bloc.dart';
import 'package:notification_app/bloc_card/FormFields/Fields/bloc_form_field.dart';
import 'package:notification_app/bloc_card/Listviews/animated_list_factory.dart';

class Test {
  final WidgetTester tester;

  Test(this.tester);

  Widget getForm(Widget widget) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            children: [
              widget,
              ElevatedButton(
                  onPressed: () {
                    formKey.currentState!.validate();
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadListItem(AnimatedListSelection selection, Bloc bloc,
      {Object? error}) async {
    GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

    AnimatedListFactory animatedListFactory = AnimatedListFactory(bloc, error);
    Widget animatedList =
        animatedListFactory.get(selection, listKey);
    await tester.pumpWidget(getForm(animatedList));
  }

  Future<void> loadField(String error) async {
    Widget field = BlocFormField(
        errorText: error,
        label: "label",
        onUpdate: (string) => null,
        textEditingController: TextEditingController(),
        icon: Icons.abc);
    await tester.pumpWidget(getForm(field));
  }

  Future<void> enterTextInBottomSheet(String enterText, int index) async {
    if (index > find.byType(TextField).evaluate().length - 1) {
      printOnFailure(
          "Error: Form only contains ${find.byType(TextField).evaluate().length} text field(s)");
    }
    await tester.enterText(find.byType(TextField).at(index), enterText);
    await tester.pump();
  }

  Future<void> tap({required String textContaining}) async {
    int count = find.textContaining(textContaining).evaluate().length;
    if (count > 1) {
      await tester.tap(find.textContaining(textContaining).at(count - 1));
      await tester.pumpAndSettle();
      return;
    }
    await tester.tap(find.textContaining(textContaining));
    await tester.pumpAndSettle();
  }

  Future<void> tapCloseIcon() async {
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
  }

  Bloc? getBloc(AnimatedListSelection animatedListSelection) {
    switch (animatedListSelection) {
      case AnimatedListSelection.emails:
      case AnimatedListSelection.contacts:
        return LandlordInfoBloc();
      case AnimatedListSelection.parkingDescription:
        return RentalAddressBloc();
      case AnimatedListSelection.rentService:
      case AnimatedListSelection.paymentOptions:
        break;
      case AnimatedListSelection.services:
        break;
      case AnimatedListSelection.utilities:
        break;
      case AnimatedListSelection.rentDiscounts:
        break;
      case AnimatedListSelection.deposits:
        break;
      case AnimatedListSelection.additionalTerms:
        break;
    }
    return null;
  }

  Future<void> add(AnimatedListSelection selection,
      {String name = "", String amount = ""}) async {
    Bloc bloc = getBloc(selection)!;
    await loadListItem(selection, bloc);
    await tap(textContaining: "Add");
    if (name.isNotEmpty) {
      await enterTextInBottomSheet(name, 0);
    }
    if (amount.isNotEmpty) {
      await enterTextInBottomSheet(amount, 1);
    }
    await tap(textContaining: "Add");
  }

  Future<void> remove(AnimatedListSelection selection,
      {String name = "", String amount = ""}) async {
    Bloc bloc = getBloc(selection)!;
    await loadListItem(selection, bloc);
    await tap(textContaining: "Add");
    if (name.isNotEmpty) {
      await enterTextInBottomSheet(name, 0);
    }
    if (amount.isNotEmpty) {
      await enterTextInBottomSheet(amount, 1);
    }
    await tap(textContaining: "Add");
    await tapCloseIcon();
  }

  Future<void> edit(AnimatedListSelection selection, String changeTo,
      {String name = "", String amount = ""}) async {
    Bloc bloc = getBloc(selection)!;
    await loadListItem(selection, bloc);
    await tap(textContaining: "Add");
    if (name.isNotEmpty) {
      await enterTextInBottomSheet(name, 0);
    }
    if (amount.isNotEmpty) {
      await enterTextInBottomSheet(amount, 1);
    }
    await tap(textContaining: "Add");
    if (name.isNotEmpty) {
      await tap(textContaining: name);
      await enterTextInBottomSheet(changeTo, 0);
    }
    await tap(textContaining: "Add");
    await loadListItem(selection, bloc);
  }

  Future<void> resourceAlreadyExists(
      AnimatedListSelection selection, String error, String text) async {
    Bloc bloc = getBloc(selection)!;
    await loadListItem(selection, bloc,
        error: {error: "Error $text already exists."});
  }
}
