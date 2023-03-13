import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/lease/rent/rent_service/rent_service_error_key.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class RentServiceBloc extends Bloc<RentService> {
  final RentService _rentService = CustomRentService("", "");

  @override
  RentService getData() {
    return _rentService;
  }

  @override
  void initStreamListen() {
    eventStream.listen((event) {
      switch (event) {
        case StreamState.update:
          addToStream(_rentService);
          break;
        case StreamState.error:
          break;
      }
    });
  }

  @override
  bool getSelectionValue(Enum errorKey) {
    // TODO: implement getSelectionValue
    throw UnimplementedError();
  }

  @override
  String? getFieldValue(Enum errorKey) {
    switch (errorKey as RentServiceErrorKey) {
      case RentServiceErrorKey.rentServiceName:
        return _rentService.name;
      case RentServiceErrorKey.rentServiceAmount:
        return _rentService.amount;
    }
  }

  @override
  String? setTextChanged(String text, Enum errorKey) {
    switch (errorKey as RentServiceErrorKey) {
      case RentServiceErrorKey.rentServiceName:
        return updateField(text, _rentService.updateName, errorKey);
      case RentServiceErrorKey.rentServiceAmount:
        return updateField(text, _rentService.updateAmount, errorKey);
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

