import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/resources/socket_clinet.dart';
import 'package:tictactoe/screens/game_view.dart';
import 'package:tictactoe/screens/main_menu_view.dart';
import 'package:tictactoe/utils/show_result_dialog.dart';
import 'package:tictactoe/utils/snackbar.dart';

class SocketMethods {
  final _socketClient = SocketClinet.instance.socket!;

  Socket get socketClient => _socketClient;

  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickName': nickName,
      });
    }
  }

  void joinRoom(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickName': nickName,
        'roomId': roomId,
      });
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on(
      'createRoomSuccess',
      (room) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateRoomData(room);
        Navigator.pushNamed(context, GameView.routeName);
      },
    );
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameView.routeName);
    });
  }

  void errorOccurredListner(BuildContext context) {
    _socketClient.on('errorOccurred', (error) {
      showSnackBar(context, error);
    });
  }

  void updatePlayerStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);

      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tapGrid(int index, String roomId, List<String> displayElement) {
    if (displayElement[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElement(data['index'], data['choice']);
      roomDataProvider.updateRoomData(data['room']);
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreased(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    _socketClient.on('pointsIncreased', (playerData) {
      if (playerData['socketId'] == roomDataProvider.player1.socketId) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  void endGame(BuildContext context) {
    _socketClient.on('endGame', (player) {
      showResultDialog(context, '${player['nickName']} won the game!');
      Navigator.pushNamedAndRemoveUntil(
          context, MainMenuView.routeName, (Route<dynamic> route) => false);
    });
  }
}
