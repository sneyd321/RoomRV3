import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/lease/rental_address/rental_address_error_key.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class RentalAddressBloc extends Bloc<RentalAddress> {
  RentalAddress _rentalAddress = RentalAddress();
  bool _parkingDescriptionToggle = true;

  RentalAddressBloc.fromLease(Lease lease) : super() {
    _rentalAddress = lease.rentalAddress;
  }

  @override
  String? setTextChanged(String text, Enum errorKey) {
    switch (errorKey as RentalAddressErrorKey) {
      case RentalAddressErrorKey.streetNumber:
        return updateField(text, _rentalAddress.updateStreetNumber, errorKey);
      case RentalAddressErrorKey.streetName:
        return updateField(text, _rentalAddress.updateStreetName, errorKey);
      case RentalAddressErrorKey.city:
        return updateField(text, _rentalAddress.updateCity, errorKey);
      case RentalAddressErrorKey.province:
        return updateField(text, _rentalAddress.updateProvince, errorKey);
      case RentalAddressErrorKey.postalCode:
        return updateField(text, _rentalAddress.updatePostalCode, errorKey);
      case RentalAddressErrorKey.unitName:
        return updateField(text, _rentalAddress.updateUnitName, errorKey);
      default:
        return null;
    }
  }

  @override
  void initStreamListen() {
    eventStream.listen((event) {
      switch (event) {
        case StreamState.update:
          addToStream(_rentalAddress);
          break;
        case StreamState.error:
          break;
      }
    });
  }

  void updateFromPredictedAddress(PredictedAddress predictedAddress) {
    _rentalAddress.updateStreetNumber(predictedAddress.streetNumber);
    _rentalAddress.updateStreetName(predictedAddress.streetName);
    _rentalAddress.updateCity(predictedAddress.city);
    _rentalAddress.updateProvince(predictedAddress.province);
    _rentalAddress.updatePostalCode(predictedAddress.postalCode);
    setUpdated(ErrorKey.empty);
  }

  @override
  RentalAddress getData() {
    return _rentalAddress;
  }

  @override
  void setSelectionChange(bool value, Enum errorKey) {
    switch (errorKey as RentalAddressErrorKey) {
      case RentalAddressErrorKey.isCondo:
        _rentalAddress.updateIsCondo(value);
        updateSelection(value, errorKey);
        break;
      case RentalAddressErrorKey.parkingDescription:
        _parkingDescriptionToggle = value;
        updateSelection(value, errorKey);
        break;
      default:
        break;
    }
  }

  @override
  bool getSelectionValue(Enum errorKey) {
    switch (errorKey as RentalAddressErrorKey) {
      case RentalAddressErrorKey.isCondo:
        return _rentalAddress.isCondo;
      case RentalAddressErrorKey.parkingDescription:
        return _parkingDescriptionToggle;
      default:
        return false;
    }
  }

  @override
  String? getFieldValue(Enum errorKey) {
    switch (errorKey as RentalAddressErrorKey) {
      case RentalAddressErrorKey.streetNumber:
        return _rentalAddress.streetNumber;
      case RentalAddressErrorKey.streetName:
        return _rentalAddress.streetName;
      case RentalAddressErrorKey.city:
        return _rentalAddress.city;
      case RentalAddressErrorKey.province:
        return _rentalAddress.province;
      case RentalAddressErrorKey.postalCode:
        return _rentalAddress.postalCode;
      case RentalAddressErrorKey.unitName:
        return _rentalAddress.unitName;
      default:
        return null;
    }
  }

  @override
  String getText(Enum errorKey) {
    throw UnimplementedError();
  }

  @override
  int getLength(Enum errorKey) {
    switch (errorKey as RentalAddressErrorKey) {
      case RentalAddressErrorKey.parkingDescriptions:
        return _rentalAddress.parkingDescriptions.length;
      default:
        return 0;
    }
  }

  @override
  void add(item, Enum errorKey) {
    switch (errorKey as RentalAddressErrorKey) {
      case RentalAddressErrorKey.parkingDescriptions:
        List<ParkingDescription> parkingDescriptions =
            _rentalAddress.parkingDescriptions;
        parkingDescriptions.add(item as ParkingDescription);
        _rentalAddress.updateParkingDescription(parkingDescriptions);
        validateList(_rentalAddress.validation,
            RentalAddressErrorKey.parkingDescriptions);
        break;
      default:
        break;
    }
  }

  @override
  void remove(int index, Enum errorKey) {
    switch (errorKey as RentalAddressErrorKey) {
      case RentalAddressErrorKey.parkingDescriptions:
        List<ParkingDescription> parkingDescriptions =
            _rentalAddress.parkingDescriptions;
        parkingDescriptions.removeAt(index);
        _rentalAddress.updateParkingDescription(parkingDescriptions);
        setUpdated(ErrorKey.empty);
        break;
      default:
        break;
    }
  }

  @override
  void update(item, int index, Enum errorKey) {
    switch (errorKey as RentalAddressErrorKey) {
      case RentalAddressErrorKey.parkingDescriptions:
        List<ParkingDescription> parkingDescriptions =
            _rentalAddress.parkingDescriptions;
        ParkingDescription parkingDescription = item as ParkingDescription;
        parkingDescriptions
            .elementAt(index)
            .updateDescription(parkingDescription.name);
        _rentalAddress.updateParkingDescription(parkingDescriptions);
        validateList(_rentalAddress.validation,
            RentalAddressErrorKey.parkingDescriptions);
        break;
      default:
        break;
    }
  }
  
  @override
  String getStringSelectionValue(Enum errorKey) {
    // TODO: implement getStringSelectionValue
    throw UnimplementedError();
  }
  
  @override
  void setEnumSelectionChange(Enum value, Enum errorKey) {
    // TODO: implement setStringSelectionChange
  }
  
  @override
  List getList(Enum errorKey) {
    switch (errorKey as RentalAddressErrorKey) {
      case RentalAddressErrorKey.parkingDescriptions:
        return _rentalAddress.parkingDescriptions;
      default:
        return [];
    }
  }
}

