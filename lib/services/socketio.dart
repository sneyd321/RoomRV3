import 'package:notification_app/services/stream_socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketIO {

  static final SocketIO _singleton = SocketIO._internal();

  factory SocketIO() {
    return _singleton;
  }

  SocketIO._internal();

  final StreamSocket streamSocket = StreamSocket();
  final IO.Socket socket = IO.io(
      'https://address-service-s5xgw6tidq-uc.a.run.app',
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect()
          .enableForceNew() // disable auto-connection
          .build());

  bool _hasFailedToConnect = false;

  bool get hasFailedToConnect => _hasFailedToConnect;
  Stream<List<dynamic>> get stream => streamSocket.getResponse;

  void emit(String value) {
    socket.emit('message', value);
    socket.on('event', (data) {
      print(data);
      streamSocket.addResponse(data);
    });
    socket.onConnectError((data) {
      _hasFailedToConnect = true;
    });
  }



  void clearStream() {
    streamSocket.addResponse([]);
  }


  void init() {
    socket.connect();
    socket.onConnect((_) {});
  }

  void dispose() {
    socket.disconnect();
    socket.onDisconnect((_) {
      print("disconnect");
    });
    socket.dispose();
  }

}