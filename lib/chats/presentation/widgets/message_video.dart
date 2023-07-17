import 'package:flutter/material.dart';

import '../pages/videoplayer_screen.dart';

class MessageVideo extends StatefulWidget {
  String urlvideo;
  MessageVideo({Key? key, required this.urlvideo}) : super(key: key);

  @override
  State<MessageVideo> createState() => _MessageVideoState();
}

class _MessageVideoState extends State<MessageVideo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(videoUrl: widget.urlvideo),
            ),
          );
        },
        child: Container(
          width: 200,
          height: 200,
          color: Colors.black,
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
