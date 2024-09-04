import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_clinet.dart';
import 'package:tictactoe/screens/game_view.dart';

class SocketMethods {
  final _socketClient = SocketClinet.instance.socket!;

  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickName': nickName,
      });
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      'createRoomSuccess',
      (room) {
        Navigator.pushNamed(context, GameView.routeName);
      },
    );
  }
}
