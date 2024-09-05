import 'package:flutter/material.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/screens/main_menu_view.dart';

void showResultDialog(BuildContext context, String text) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                GameMethods().clearBoard(context);
              },
              child: const Text('Play Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context,
                    MainMenuView.routeName, (Route<dynamic> route) => false);
              },
              child: const Text('leave game'),
            )
          ],
        );
      });
}
