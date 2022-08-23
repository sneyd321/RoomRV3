
import 'dart:async';

class StreamSocket {
  final _socketResponse = StreamController<List<dynamic>>();

  void Function(List<dynamic>) get addResponse => _socketResponse.sink.add;

  Stream<List<dynamic>> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}