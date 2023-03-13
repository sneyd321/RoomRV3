import 'package:notification_app/bloc/bloc.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class ParkingDescriptionBloc extends Bloc<ParkingDescription> {
  final ParkingDescription _parkingDescription = ParkingDescription();
  ParkingDescriptionBloc() : super();

  @override
  String? setTextChanged(String text, Enum errorKey) {
    switch (errorKey as ParkingDescriptionErrorKey) {
      case ParkingDescriptionErrorKey.parkingDescriptionName:
        return updateField(
            text, _parkingDescription.updateDescription, errorKey);
    }
  }

  @override
  ParkingDescription getData() {
    return _parkingDescription;
  }

  @override
  void initStreamListen() {
    eventStream.listen((event) {
      switch (event) {
        case StreamState.update:
          addToStream(_parkingDescription);
          break;
        case StreamState.error:
          break;
      }
    });
  }

  @override
  bool getSelectionValue(Enum errorKey) {
    return false;
  }

  @override
  String? getFieldValue(Enum errorKey) {
    switch (errorKey as ParkingDescriptionErrorKey) {
      case ParkingDescriptionErrorKey.parkingDescriptionName:
        return _parkingDescription.name;
    }
  }
  
  @override
  String getText(Enum errorKey) {
    throw UnimplementedError();
  }
  
  @override
  int getLength(Enum errorKey) {
    throw UnimplementedError();
  }
  
  @override
  void setSelectionChange(bool value, Enum errorKey) {
  }
  
  @override
  void add(item, Enum errorKey) {
    // TODO: implement add
  }
  
  @override
  void remove(int index, Enum errorKey) {
    // TODO: implement remove
  }
  
  @override
  void update(item, int index, Enum errorKey) {
    // TODO: implement update
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
    // TODO: implement getList
    throw UnimplementedError();
  }
}

enum ParkingDescriptionErrorKey { parkingDescriptionName }
