import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClinet {
  IO.Socket? socket;
  static SocketClinet? _instance;

  SocketClinet._internal() {
    socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static SocketClinet get instance {
    _instance ??= SocketClinet._internal();
    return _instance!;
  }
}
