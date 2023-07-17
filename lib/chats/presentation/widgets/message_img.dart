import 'package:flutter/material.dart';

class MessageImg extends StatefulWidget {
  String urlimg;
  MessageImg({Key? key, required this.urlimg}) : super(key: key);

  @override
  State<MessageImg> createState() => _MessageImgState();
}

class _MessageImgState extends State<MessageImg> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(widget.urlimg),
    );
  }
}
