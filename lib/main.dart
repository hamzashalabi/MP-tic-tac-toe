import 'package:flutter/material.dart';
import 'package:tictactoe/screens/create_room_view.dart';
import 'package:tictactoe/screens/game_view.dart';
import 'package:tictactoe/screens/join_room_view.dart';
import 'package:tictactoe/screens/main_menu_view.dart';
import 'package:tictactoe/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
      ),
      routes: {
        MainMenuView.routeName: (context) => const MainMenuView(),
        JoinRoomView.routeName: (context) => const JoinRoomView(),
        CreateRoomView.routeName: (context) => const CreateRoomView(),
        GameView.routeName: (context) => const GameView(),
      },
      initialRoute: MainMenuView.routeName,
    );
  }
}
