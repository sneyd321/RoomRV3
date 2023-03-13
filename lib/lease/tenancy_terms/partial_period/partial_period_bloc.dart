import 'package:notification_app/bloc/bloc.dart';
import 'package:notification_app/lease/tenancy_terms/partial_period/partial_period_error_key.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class PartialPeriodBloc extends Bloc<PartialPeriod> {
  final PartialPeriod _partialPeriod = PartialPeriod();

  @override
  void add(item, Enum errorKey) {
    // TODO: implement add
  }

  @override
  PartialPeriod getData() => _partialPeriod;
  @override
  String? getFieldValue(Enum errorKey) {
    switch (errorKey as PartialPeriodErrorKey) {
      case PartialPeriodErrorKey.partialPeriodStartDate:
        return _partialPeriod.startDate;
      case PartialPeriodErrorKey.partialPeriodEndDate:
        return _partialPeriod.endDate;
      case PartialPeriodErrorKey.partialPeriodAmount:
        return _partialPeriod.amount;
      case PartialPeriodErrorKey.partialPeriodDueDate:
        return _partialPeriod.dueDate;
      default:
        return null;
    }
  }

  @override
  int getLength(Enum errorKey) => 0;

  @override
  List getList(Enum errorKey) => [];

  @override
  bool getSelectionValue(Enum errorKey) {
    switch (errorKey as PartialPeriodErrorKey) {
      case PartialPeriodErrorKey.isEnabled:
        return _partialPeriod.enabled;
      default:
        return false;
    } 
  }

  @override
  String getStringSelectionValue(Enum errorKey) => "";

  @override
  String getText(Enum errorKey) => "";

  @override
  void initStreamListen() {
    eventStream.listen((event) {
      switch (event) {
        case StreamState.update:
          addToStream(_partialPeriod);
          break;
        case StreamState.error:
          break;
      }
    });
  }

  @override
  void remove(int index, Enum errorKey) {
   
  }

  @override
  void setEnumSelectionChange(Enum value, Enum errorKey) {
   
  }

  @override
  void setSelectionChange(bool value, Enum errorKey) {
  switch (errorKey as PartialPeriodErrorKey) {
      case PartialPeriodErrorKey.isEnabled:
        _partialPeriod.updateEnabled(value);
        updateSelection(value, errorKey);
        break;
      default:
        break;
    }
  }

  @override
  String? setTextChanged(String text, Enum errorKey) {
    switch (errorKey as PartialPeriodErrorKey) {
      case PartialPeriodErrorKey.partialPeriodStartDate:
        return updateField(text, _partialPeriod.updateStartDate, errorKey);
      case PartialPeriodErrorKey.partialPeriodEndDate:
        return updateField(text, _partialPeriod.updateEndDate, errorKey);
      case PartialPeriodErrorKey.partialPeriodAmount:
        return updateField(text, _partialPeriod.updateAmount, errorKey);
      case PartialPeriodErrorKey.partialPeriodDueDate:
        return updateField(text, _partialPeriod.updateDueDate, errorKey);
      default:
        return null;
    }
  }

  @override
  void update(item, int index, Enum errorKey) {
    // TODO: implement update
  }
}
