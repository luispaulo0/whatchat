import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MessageAudio extends StatefulWidget {
  String audioUrl;
  MessageAudio({Key? key, required this.audioUrl}) : super(key: key);

  @override
  State<MessageAudio> createState() => _MessageAudioState();
}

class _MessageAudioState extends State<MessageAudio> {
  ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (isPlaying.value) {
            audioPlayer.pause();
            isPlaying.value = false;
          } else {
            audioPlayer.play(UrlSource(widget.audioUrl));
            isPlaying.value = true;
          }
        },
        child: Container(
          width: 200,
          height: 50,
          color: Colors.black,
          child: ValueListenableBuilder<bool>(
            valueListenable: isPlaying,
            builder: (context, value, _) {
              return Icon(
                value ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 30,
              );
            },
          ),
        ),
      ),
    );
  }
}
