import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/lease/landlord_info/landlord_info_error_key.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class LandlordInfoBloc extends Bloc<LandlordInfo> {
  LandlordInfo _landlordInfo = LandlordInfo();
  LandlordInfoBloc() : super();

  LandlordInfoBloc.fromLandlord(Landlord landlord) : super() {
    _landlordInfo = LandlordInfo.fromLandlord(landlord);
  }

  LandlordInfoBloc.fromLease(Lease lease) : super() {
    _landlordInfo = lease.landlordInfo;
  }

  @override
  String? setTextChanged(String text, Enum errorKey) {
    switch (errorKey as LandlordInfoErrorKey) {
      case LandlordInfoErrorKey.fullName:
        return updateField(text, _landlordInfo.updateFullName, errorKey);
      default:
        return null;
    }
  }

  @override
  void setSelectionChange(bool value, Enum errorKey) {
    switch (errorKey as LandlordInfoErrorKey) {
      case LandlordInfoErrorKey.receiveDocumentsByEmail:
        _landlordInfo.updateReceiveDocumentsByEmail(value);
        updateSelection(value, errorKey);
        break;
      case LandlordInfoErrorKey.contactInfo:
        _landlordInfo.updateContactInfo(value);
        updateSelection(value, errorKey);
        break;
      default:
        break;
    }
  }

  @override
  bool getSelectionValue(Enum errorKey) {
    switch (errorKey as LandlordInfoErrorKey) {
      case LandlordInfoErrorKey.receiveDocumentsByEmail:
        return _landlordInfo.receiveDocumentsByEmail;
      case LandlordInfoErrorKey.contactInfo:
        return _landlordInfo.contactInfo;
      default:
        return false;
    }
  }

  @override
  void initStreamListen() {
    eventStream.listen((event) {
      switch (event) {
        case StreamState.update:
          addToStream(_landlordInfo);
          break;
        case StreamState.error:
          break;
      }
    });
  }

  @override
  LandlordInfo getData() {
    return _landlordInfo;
  }

  @override
  String? getFieldValue(Enum errorKey) {
    switch (errorKey as LandlordInfoErrorKey) {
      case LandlordInfoErrorKey.fullName:
        return _landlordInfo.fullName;
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
    switch (errorKey as LandlordInfoErrorKey) {
      case LandlordInfoErrorKey.emails:
        return _landlordInfo.emails.length;
      case LandlordInfoErrorKey.contacts:
        return _landlordInfo.contacts.length;
      default:
        return 0;
    }
  }

  @override
  void add(item, Enum errorKey) {
    switch (errorKey as LandlordInfoErrorKey) {
      case LandlordInfoErrorKey.emails:
        List<Email> emails = _landlordInfo.emails;
        emails.add(item as Email);
        _landlordInfo.updateEmails(emails);
        validateList(
            _landlordInfo.emailValidation, LandlordInfoErrorKey.emails);
        break;
      case LandlordInfoErrorKey.contacts:
        List<Contact> contacts = _landlordInfo.contacts;
        contacts.add(item as Contact);
        _landlordInfo.updateContacts(contacts);
        validateList(
            _landlordInfo.contactValidation, LandlordInfoErrorKey.contacts);
        break;
      default:
        break;
    }
  }

  @override
  void remove(int index, Enum errorKey) {
    switch (errorKey as LandlordInfoErrorKey) {
      case LandlordInfoErrorKey.emails:
        List<Email> emails = _landlordInfo.emails;
        emails.removeAt(index);
        _landlordInfo.updateEmails(emails);
        setUpdated(ErrorKey.empty);
        break;
      case LandlordInfoErrorKey.contacts:
        List<Contact> contacts = _landlordInfo.contacts;
        contacts.removeAt(index);
        _landlordInfo.updateContacts(contacts);
        setUpdated(ErrorKey.empty);
        break;
      default:
        break;
    }
  }

  @override
  void update(item, int index, Enum errorKey) {
    switch (errorKey as LandlordInfoErrorKey) {
      case LandlordInfoErrorKey.emails:
        List<Email> emails = _landlordInfo.emails;
        Email email = item as Email;
        emails.elementAt(index).updateEmail(email.name);
        _landlordInfo.updateEmails(emails);
        validateList(
            _landlordInfo.emailValidation, LandlordInfoErrorKey.emails);
        break;
      case LandlordInfoErrorKey.contacts:
        List<Contact> contacts = _landlordInfo.contacts;
        Contact contact = item as Contact;
        contacts.elementAt(index).updateContact(contact.name);
        _landlordInfo.updateContacts(contacts);
        validateList(
            _landlordInfo.contactValidation, LandlordInfoErrorKey.contacts);
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
    switch (errorKey as LandlordInfoErrorKey) {
      case LandlordInfoErrorKey.emails:
        return _landlordInfo.emails;
      case LandlordInfoErrorKey.contacts:
        return _landlordInfo.contacts;
      default:
        return [];
    }
  }
}

