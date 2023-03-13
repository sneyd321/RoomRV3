import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/lease/tenancy_terms/partial_period/partial_period_error_key.dart';
import 'package:notification_app/lease/tenancy_terms/tenancy_terms_error_key.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class TenancyTermsBloc extends Bloc<TenancyTerms> {
  TenancyTerms _tenancyTerms = TenancyTerms();

  TenancyTermsBloc() : super();

  TenancyTermsBloc.fromLease(Lease lease) : super() {
    _tenancyTerms = lease.tenancyTerms;
  }

  @override
  TenancyTerms getData() {
    return _tenancyTerms;
  }

  @override
  String? getFieldValue(Enum errorKey) {
    switch (errorKey as TenancyTermsErrorKey) {
      case TenancyTermsErrorKey.startDate:
        return _tenancyTerms.startDate;
      case TenancyTermsErrorKey.endDate:
        return _tenancyTerms.rentalPeriod.endDate;
      default:
        return "";
    }
  }

  @override
  void initStreamListen() {
    eventStream.listen((event) {
      switch (event) {
        case StreamState.update:
          addToStream(_tenancyTerms);
          break;
        case StreamState.error:
          break;
      }
    });
  }

  @override
  String? setTextChanged(String text, Enum errorKey) {
    switch (errorKey as TenancyTermsErrorKey) {
      case TenancyTermsErrorKey.startDate:
        return updateField(text, _tenancyTerms.updateStartDate, errorKey);
      case TenancyTermsErrorKey.endDate:
        return updateField(
            text, _tenancyTerms.rentalPeriod.updateEndDate, errorKey);
      default:
        return null;
    }
  }

  @override
  String getStringSelectionValue(Enum errorKey) {
    switch (errorKey as TenancyTermsErrorKey) {
      case TenancyTermsErrorKey.rentDueDate:
        return _tenancyTerms.rentDueDate;
      case TenancyTermsErrorKey.paymentPeriod:
        return _tenancyTerms.paymentPeriod;
      case TenancyTermsErrorKey.rentalPeriod:
        return _tenancyTerms.rentalPeriod.rentalPeriod;
      default:
        return "";
    }
  }

  @override
  void setEnumSelectionChange(Enum value, Enum errorKey) {
    switch (errorKey as TenancyTermsErrorKey) {
      case TenancyTermsErrorKey.rentDueDate:
        if (_tenancyTerms.paymentPeriod == "Daily") {
          _tenancyTerms.updateRentDueDate(RentDueDateOption.first);
          setUpdated(errorKey);
          break;
        }
        _tenancyTerms.updateRentDueDate(value as RentDueDateOption);
        setUpdated(errorKey);
        break;
      case TenancyTermsErrorKey.paymentPeriod:
        _tenancyTerms.updatePaymentPeriod(value as PaymentPeriodOption);
        setUpdated(errorKey);
        break;
      case TenancyTermsErrorKey.rentalPeriod:
        RentalPeriod rentalPeriod = RentalPeriod();
        rentalPeriod.updateRentalPeriod(value as RentalPeriodOption);
        _tenancyTerms.updateRentalPeriod(rentalPeriod);
        setUpdated(errorKey);
        break;
      default:
        break;
    }
  }

  @override
  void setSelectionChange(bool value, Enum errorKey) {
    
  }

  @override
  bool getSelectionValue(Enum errorKey) {
    
    return false;
  }

  @override
  int getLength(Enum errorKey) => 0;
  @override
  void add(item, Enum errorKey) {}
  @override
  String getText(Enum errorKey) => "";
  @override
  void remove(int index, Enum errorKey) {}
  @override
  void update(item, int index, Enum errorKey) {}

  @override
  List getList(Enum errorKey) {
    // TODO: implement getList
    throw UnimplementedError();
  }
}
