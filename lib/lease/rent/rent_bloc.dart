import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/lease/rent/rent_error_key.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class RentBloc extends Bloc<Rent> {
  Rent _rent = Rent();
  RentBloc() : super();
  RentBloc.fromLease(Lease lease) : super() {
    _rent = lease.rent;
  }

  @override
  Rent getData() {
    return _rent;
  }

  @override
  void initStreamListen() {
    eventStream.listen((event) {
      switch (event) {
        case StreamState.update:
          addToStream(_rent);
          break;
        case StreamState.error:
          break;
      }
    });
  }

  @override
  bool getSelectionValue(Enum errorKey) {
    if (errorKey is ErrorKey) {
      return true;
    }
    switch (errorKey as RentErrorKey) {
      case RentErrorKey.rentServices:
        return true;
      case RentErrorKey.paymentOptions:
        return true;
      default:
        return false;
    }
  }

  @override
  String? setTextChanged(String text, Enum errorKey) {
    switch (errorKey as RentErrorKey) {
      case RentErrorKey.baseRent:
        String? result = updateField(text, _rent.updateBaseRent, errorKey);
        if (result != null) {
          _rent.updateBaseRent("0.00");
        }
        return result;
      case RentErrorKey.rentMadePayableTo:
        return updateField(text, _rent.updateRentMadePayableTo, errorKey);
      default:
        return null;
    }
  }

  @override
  String? getFieldValue(Enum errorKey) {
    switch (errorKey) {
      case RentErrorKey.baseRent:
        return _rent.baseRent;
      case RentErrorKey.rentMadePayableTo:
        return _rent.rentMadePayableTo;
      default:
        return null;
    }
  }

  @override
  String getText(Enum errorKey) {
    switch (errorKey as RentErrorKey) {
      case RentErrorKey.totalLawfulRent:
        return _rent.getTotalLawfulRent();
      default:
        return "";
    }
  }

  @override
  int getLength(Enum errorKey) {
    switch (errorKey as RentErrorKey) {
      case RentErrorKey.rentServices:
        return _rent.rentServices.length;
      case RentErrorKey.paymentOptions:
        return _rent.paymentOptions.length;
      default:
        return 0;
    }
  }

  @override
  void setSelectionChange(bool value, Enum errorKey) {}

  @override
  void add(item, Enum errorKey) {
    switch (errorKey as RentErrorKey) {
      case RentErrorKey.rentServices:
        List<RentService> rentServices = _rent.rentServices;
        rentServices.add(item as RentService);
        _rent.updateRentServices(rentServices);
        validateList(_rent.rentServiceValidation, RentErrorKey.rentServices);
        break;
      case RentErrorKey.paymentOptions:
        List<PaymentOption> paymentOptions = _rent.paymentOptions;
        paymentOptions.add(item as PaymentOption);
        _rent.updatePaymentOptions(paymentOptions);
        validateList(
            _rent.paymentOptionsValidation, RentErrorKey.paymentOptions);
        break;
      default:
        break;
    }
  }

  @override
  void remove(int index, Enum errorKey) {
    switch (errorKey as RentErrorKey) {
      case RentErrorKey.rentServices:
        List<RentService> rentServices = _rent.rentServices;
        rentServices.removeAt(index);
        _rent.updateRentServices(rentServices);
        setUpdated(ErrorKey.empty);
        break;
      case RentErrorKey.paymentOptions:
        List<PaymentOption> paymentOptions = _rent.paymentOptions;
        paymentOptions.removeAt(index);
        _rent.updatePaymentOptions(paymentOptions);
        setUpdated(ErrorKey.empty);
        break;
      default:
        break;
    }
  }

  @override
  void update(item, int index, Enum errorKey) {
    switch (errorKey as RentErrorKey) {
      case RentErrorKey.rentServices:
        List<RentService> rentServices = _rent.rentServices;
        RentService rentService = item as RentService;
        rentServices.elementAt(index).updateName(rentService.name);
        rentServices.elementAt(index).updateAmount(rentService.amount);
        _rent.updateRentServices(rentServices);
        validateList(_rent.rentServiceValidation, RentErrorKey.rentServices);
        break;
      case RentErrorKey.paymentOptions:
        List<PaymentOption> paymentOptions = _rent.paymentOptions;
        PaymentOption paymentOption = item as PaymentOption;
        paymentOptions.elementAt(index).updateName(paymentOption.name);
        _rent.updatePaymentOptions(paymentOptions);
        validateList(
            _rent.paymentOptionsValidation, RentErrorKey.paymentOptions);
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
    switch (errorKey as RentErrorKey) {
      case RentErrorKey.rentServices:
        return _rent.rentServices;
      case RentErrorKey.paymentOptions:
        return _rent.paymentOptions;
      default:
        return [];
    }
  }
}

