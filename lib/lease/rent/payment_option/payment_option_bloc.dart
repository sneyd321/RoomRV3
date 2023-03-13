import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/lease/rent/payment_option/payment_option_error_key.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class PaymentOptionBloc extends Bloc<PaymentOption> {
  final PaymentOption _paymentOption = CustomPaymentOption("");

  @override
  PaymentOption getData() {
    return _paymentOption;
  }

  @override
  void initStreamListen() {
     eventStream.listen((event) {
      switch (event) {
        case StreamState.update:
          addToStream(_paymentOption);
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
    switch (errorKey as PaymentOptionErrorKey) {
      case PaymentOptionErrorKey.paymentOptionName:
        return _paymentOption.name;
    }
  }

  @override
  String? setTextChanged(String text, Enum errorKey) {
    switch (errorKey as PaymentOptionErrorKey) {
      case PaymentOptionErrorKey.paymentOptionName:
        return updateField(text, _paymentOption.updateName, errorKey);
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
   
  }
  
  @override
  void remove(int index, Enum errorKey) {
    
  }
  
  @override
  void update(item, int index, Enum errorKey) {
    
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

