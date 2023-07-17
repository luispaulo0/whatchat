import 'package:flutter/material.dart';

class HeaderChat extends StatefulWidget {
  String apodo;
  HeaderChat({Key? key, required this.apodo}) : super(key: key);

  @override
  State<HeaderChat> createState() => _HeaderChatState();
}

class _HeaderChatState extends State<HeaderChat> {
  @override
  Widget build(BuildContext context) {
    return Row(
       children: [
        Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Container(
          width: 100,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(
          widget.apodo,
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
      )
       ],
    );
  }
}
