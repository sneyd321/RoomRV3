import 'package:flutter/material.dart';
import 'package:notification_app/lease/rental_address/form/field/auto_complete_address/address_auto_complete.dart';
import 'package:notification_app/lease/rental_address/form/field/city_field.dart';
import 'package:notification_app/lease/rental_address/form/field/postal_code_field.dart';
import 'package:notification_app/lease/rental_address/form/field/province_field.dart';
import 'package:notification_app/lease/rental_address/form/field/street_name_field.dart';
import 'package:notification_app/lease/rental_address/form/field/street_number_field.dart';
import 'package:notification_app/lease/rental_address/form/field/unit_name_field.dart';
import 'package:notification_app/lease/rental_address/form/parking_description_list.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/form_builder/form_container.dart';
import 'package:notification_app/lease/rental_address/form/selection/is_condo_selection.dart';
import 'package:notification_app/lease/rental_address/form/selection/parking_description_selection.dart';
import 'package:notification_app/lease/rental_address/rental_address_bloc.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class RentalAddressForm extends StatefulWidget {
  final Lease lease;
  final Function(RentalAddress rentalAddress) onUpdate;

  const RentalAddressForm({
    Key? key,
    required this.lease,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<RentalAddressForm> createState() => _RentalAddressFormState();
}

class _RentalAddressFormState extends State<RentalAddressForm>
    with TickerProviderStateMixin {
  late RentalAddressBloc rentalAddressBloc;
  late FormBuilder formBuilder;

  @override
  void initState() {
    super.initState();
    rentalAddressBloc = RentalAddressBloc.fromLease(widget.lease);
    double width = WidgetsBinding.instance.window.physicalSize.width;
    double halfWidth = width / 2;
    double twoThirdWidth = (width / 3) * 2;
    formBuilder = FormBuilder(rentalAddressBloc, tickerProvider: this)
        .add(AddressAutoComplete(top: 8, left: 8, right: 8))
        .add(StreetNumberField(top: 8, left: 8, right: 8, width: halfWidth))
        .add(StreetNameField(left: 8, right: 8, width: halfWidth))
        .add(CityField(left: 8, right: 8, width: halfWidth))
        .add(ProvinceField(left: 8, right: 8, width: halfWidth))
        .add(PostalCodeField(left: 8, right: 8, width: twoThirdWidth))
        .add(IsCondoSelection())
        .add(ParkingDescriptionSelection())
        .add(ParkingDescriptionList())
        .add(UnitNameField(top: 8, left: 8, right: 8));
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      onUpdate: () {
        widget.onUpdate(rentalAddressBloc.getData());
      },
      formBuilder: formBuilder,
      buttonText: 'Update Rental Address Bloc',
    );
  }
}
