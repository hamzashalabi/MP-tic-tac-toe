import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/responsive/responsive.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:tictactoe/widgets/custom_text.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';

class CreateRoomView extends StatefulWidget {
  static String routeName = '/create_room/';
  const CreateRoomView({super.key});

  @override
  State<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState extends State<CreateRoomView> {
  late final TextEditingController _controller;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
                fontSize: 72,
                shadows: [
                  Shadow(
                    blurRadius: 50,
                    color: Colors.blue,
                  )
                ],
                text: 'Create Room',
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                controller: _controller,
                text: 'Enter Your NickName',
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomButton(
                onPressed: () => _socketMethods.createRoom(_controller.text),
                buttonText: 'Create',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
