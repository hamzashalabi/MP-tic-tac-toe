import 'package:flutter/material.dart';
import 'package:tictactoe/screens/create_room_view.dart';
import 'package:tictactoe/screens/join_room_view.dart';
import 'package:tictactoe/widgets/custom_button.dart';

class MainMenuView extends StatelessWidget {
  static String routeName = '/main_menu/';
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, CreateRoomView.routeName);
            },
            buttonText: 'Create Room',
          ),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, JoinRoomView.routeName);
            },
            buttonText: 'Join Room',
          ),
        ],
      ),
    );
  }
}
