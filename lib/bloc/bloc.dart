import 'dart:async';

abstract class Bloc<T> {
  final StreamController<T> _stateController = StreamController.broadcast();
  final StreamController<StreamState> _eventController = StreamController();
  final Map<Enum, String> errors = {};

  Bloc() {
    initStreamListen();
  }

  Stream<T> get stream => _stateController.stream;
  Stream<StreamState> get eventStream => _eventController.stream;

  void addToStream(T t) {
    _stateController.add(t);
  }

  void setUpdated(Enum key) {
    if (errors.containsKey(key)) {
      errors.remove(key);
    }
    _eventController.add(StreamState.update);
  }

  void setError() {
    _eventController.add(StreamState.error);
  }

  void addErrorToStream(Enum key, String error) {
    _stateController.addError({key: error});
  }

  String? updateField(
      String? value, String? Function(String) update, Enum errorKey) {
    String? result = update(value!);
    if (result != null) {
      addErrorToStream(errorKey, result);
      return result;
    }
    setUpdated(errorKey);
    return result;
  }

  String formatError(List<String> validation) {
    if (validation.isEmpty) {
      return "";
    }
    String errorMessage = validation.length == 1 ? "Error " : "Errors ";
    String delimiter = validation.length == 1 ? "" : ",";
    for (String error in validation) {
      errorMessage += error + delimiter;
    }
    return errorMessage;
  }

  void validateList(List<String> validation, Enum errorKey) {
    if (validation.isNotEmpty) {
      addErrorToStream(errorKey, formatError(validation));
      return;
    }
    setUpdated(errorKey);
  }

  void updateSelection(bool value, Enum errorKey) {
    if (value == false) {
      addErrorToStream(errorKey, "isFalse");
    } else {
      setUpdated(errorKey);
    }
  }

  void updateStringSelection(String value, Enum errorKey) {
    setUpdated(errorKey);
  }

  void initStreamListen();
  T getData();
  String? setTextChanged(String text, Enum errorKey);
  void setSelectionChange(bool value, Enum errorKey);
  void setEnumSelectionChange(Enum value, Enum errorKey);
  bool getSelectionValue(Enum errorKey);
  String getStringSelectionValue(Enum errorKey);
  String? getFieldValue(Enum errorKey);
  String getText(Enum errorKey);
  List getList(Enum errorKey);
  int getLength(Enum errorKey);
  void add(dynamic item, Enum errorKey);
  void update(dynamic item, int index, Enum errorKey);
  void remove(int index, Enum errorKey);
}

enum StreamState {
  update,
  error,
}

enum ErrorKey {
  empty
}



