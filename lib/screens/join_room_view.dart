import 'package:flutter/material.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:tictactoe/widgets/custom_text.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';

class JoinRoomView extends StatefulWidget {
  static String routeName = '/join_room/';
  const JoinRoomView({super.key});

  @override
  State<JoinRoomView> createState() => _JoinRoomViewState();
}

class _JoinRoomViewState extends State<JoinRoomView> {
  late final TextEditingController _nameController;
  late final _gameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _gameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _gameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                fontSize: 88,
                shadows: [
                  Shadow(
                    blurRadius: 50,
                    color: Colors.blue,
                  )
                ],
                text: 'Join Room',
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                controller: _nameController,
                text: 'Enter Your NickName',
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomTextField(
                controller: _gameController,
                text: 'Enter Game ID',
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomButton(
                onPressed: () {},
                buttonText: 'Join',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
