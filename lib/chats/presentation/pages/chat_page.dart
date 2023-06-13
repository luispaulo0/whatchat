import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatchat/chats/domain/entities/mensaje.dart';
import 'package:whatchat/chats/presentation/usecases.dart';

class ChatPage extends StatefulWidget {
  final UseCases useCases;

  ChatPage({required this.useCases});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  VideoPlayerController? controllerVideo;
  AudioPlayer? controllerAudio;
  TextEditingController mensaje = TextEditingController(text: '');
  File? _getImg;
  File? _getVideo;
  File? _getAudio;
  bool isAudioPlaying = false;
  bool? uploaded;
  bool? uploadedV;
  bool? uploadA;
  File? img;
  // File? video;
  File? audio;
  @override
  void dispose() {
    super.dispose();
    controllerVideo?.dispose();
    controllerAudio?.dispose();
  }

  Future<void> _getAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if (result != null) {
      _getAudio = File(result.files.single.path!);
      setState(() {
        controllerAudio?.dispose();
        audio = File(_getAudio!.path);
        controllerAudio = AudioPlayer();
      });
      if (audio != null) {
        String audioPath = audio!.path;
        controllerAudio!.play(UrlSource(audioPath));
        setState(() {
          isAudioPlaying = true;
        });
      }
    }
  }

  Future<void> _getImgFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      _getImg = File(result.files.single.path!);
      img = File(_getImg!.path);
    }
  }

  Future<void> _getVideoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      _getVideo = File(result.files.single.path!);
      setState(() {
        controllerVideo?.dispose();
        controllerVideo = VideoPlayerController.file(File(_getVideo!.path));
      });
      await controllerVideo!.initialize();
      setState(() {});
    }
  }

  Future<void> _enviarMensaje() async {
    final mensaje = Mensaje(
      imagenFile: _getImg,
      videoFile: _getVideo,
      audioFile: _getAudio,
    );

    if (widget.useCases.enviarMensajeUseCase != null) {
      await widget.useCases.enviarMensajeUseCase?.execute(mensaje);
    }

    setState(() {
      _getImg = null;
      _getVideo = null;
      _getAudio = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatChat'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                if (img != null) Image.file(img!),
                if (controllerVideo != null)
                  AspectRatio(
                    aspectRatio: controllerVideo!.value.aspectRatio,
                    child: GestureDetector(
                      onTap: () {
                        if (controllerVideo!.value.isPlaying) {
                          controllerVideo!.pause();
                        } else {
                          controllerVideo!.play();
                        }
                      },
                      child: VideoPlayer(controllerVideo!),
                    ),
                  ),
                if (audio != null)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isAudioPlaying) {
                          controllerAudio!.pause();
                          isAudioPlaying = false;
                        } else {
                          controllerAudio!.resume();
                          isAudioPlaying = true;
                        }
                      });
                    },
                    child: Icon(
                      isAudioPlaying ? Icons.pause : Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
            Container(
              color: Colors.red,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                        onPressed: _getImgFile,
                        icon: const Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: IconButton(
                        onPressed: _getVideoFile,
                        icon: const Icon(
                          Icons.video_camera_back_outlined,
                          size: 40,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: IconButton(
                          onPressed: _getAudioFile,
                          icon: const Icon(
                            Icons.mic_none_sharp,
                            size: 40,
                            color: Colors.white,
                          ))),
                  Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        width: screenWidth * 0.39,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white, border: Border.all(width: 1)),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: IconButton(
                        onPressed: _enviarMensaje,
                        icon: const Icon(
                          Icons.send,
                          size: 40,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
