import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/widgets/custom_text.dart';
import 'package:tictactoe/widgets/score_bored.dart';
import 'package:tictactoe/widgets/tictactoe_bored.dart';
import 'package:tictactoe/widgets/waiting_lobby.dart';

class GameView extends StatefulWidget {
  static String routeName = '/game/';
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayerStateListener(context);
    _socketMethods.pointIncreased(context);
    _socketMethods.endGame(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ScoreBored(),
                  const TictactoeBored(),
                  CustomText(
                    fontSize: 20,
                    shadows: const [
                      Shadow(
                        blurRadius: 16,
                        color: Colors.blue,
                      ),
                    ],
                    text:
                        "${roomDataProvider.roomData['turn']['nickName']}'s turn",
                  ),
                ],
              ),
            ),
    );
  }
}
