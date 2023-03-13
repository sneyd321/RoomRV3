import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/lease/landlord_info/email/email_error_key.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class EmailBloc extends Bloc<Email> {
  final Email _email = Email();

  EmailBloc() : super();

  @override
  String? setTextChanged(String text, Enum errorKey) {
    switch (errorKey as EmailErrorKey) {
      case EmailErrorKey.emailName:
        return updateField(text, _email.updateEmail, errorKey);
    }
  }

  @override
  void initStreamListen() {
    eventStream.listen((event) {
      switch (event) {
        case StreamState.update:
          addToStream(_email);
          break;
        case StreamState.error:
          break;
      }
    });
  }

  @override
  Email getData() {
    return _email;
  }

  @override
  bool getSelectionValue(Enum errorKey) {
    return false;
  }

  @override
  String? getFieldValue(Enum errorKey) {
    switch (errorKey as EmailErrorKey) {
      case EmailErrorKey.emailName:
        return _email.name;
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
  void setSelectionChange(bool value, Enum errorKey) {}

  @override
  void add(item, Enum errorKey) {}

  @override
  void remove(int index, Enum errorKey) {}

  @override
  void update(item, int index, Enum errorKey) {}
  
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


