import 'package:flutter/material.dart';

class MessageText extends StatefulWidget {
  String text;
  bool emisor;
  MessageText({Key? key, required this.text, required this.emisor})
      : super(key: key);

  @override
  State<MessageText> createState() => _MessageTextState();
}

class _MessageTextState extends State<MessageText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          widget.text,
          style: TextStyle(
              color: widget.emisor ? Colors.white : Colors.black, fontSize: 22),
        ));
  }
}
