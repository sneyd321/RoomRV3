import 'package:flutter/material.dart';
import 'package:notification_app/lease/rental_address/form/field/auto_complete_address/suggested_address_card.dart';
import 'package:notification_app/bloc/fields/field.dart';
import 'package:notification_app/lease/rental_address/rental_address_bloc.dart';
import 'package:notification_app/lease/rental_address/rental_address_error_key.dart';
import 'package:notification_app/services/socketio.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class AddressAutoComplete extends Field {
  AddressAutoComplete({top, left, right, bottom, width})
      : super(
            top: top, left: left, right: right, bottom: bottom, width: width) {
    textEditingController.addListener(onChanged);
    SocketIO().init();
  }

  void onChanged() {
    if (textEditingController.text.length > 3) {
      SocketIO().emit(textEditingController.text);
    } else {
      SocketIO().clearStream();
    }
  }

  @override
  Widget build(Object? error) {
    return Container(
      margin: EdgeInsets.only(
          top: top ?? 0,
          left: left ?? 0,
          right: right ?? 0,
          bottom: bottom ?? 0),
      width: width,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: textEditingController,
            keyboardType: TextInputType.streetAddress,
            maxLines: 1,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                prefixIcon: Icon(icon),
                labelText: label,
                suffixIcon: IconButton(
                    onPressed: (() {
                      textEditingController.clear();
                    }),
                    icon: const Icon(Icons.close))),
            onSaved: (String? value) {},
            validator: (String? value) {
              if (SocketIO().hasFailedToConnect) {
                return "Service currently unavailable";
              }
            },
          ),
          StreamBuilder(
            stream: SocketIO().stream,
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data == null) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    child: SuggestedAddressCard(
                      rentalAddressBloc: bloc as RentalAddressBloc,
                      suggestedAddress:
                          SuggestedAddress.fromJson(snapshot.data![index]),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  @override
  void setErrorKey() {
    errorKey = RentalAddressErrorKey.addressAutoComplete;
  }

  @override
  void setIcon() {
    icon = Icons.home;
  }

  @override
  void setLabel() {
    label = "Auto Complete Address";
  }

  @override
  void dispose() {
    SocketIO().dispose();
    super.dispose();
  }
}
