import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:whatchat/chats/data/datasources/select_audio.dart';
import 'package:whatchat/chats/data/datasources/select_image.dart';
import 'package:whatchat/chats/data/datasources/select_video.dart';
import 'package:whatchat/chats/data/datasources/upload_audio.dart';
import 'package:whatchat/chats/data/datasources/upload_image.dart';
import 'package:whatchat/chats/data/datasources/upload_video.dart';
import 'package:video_player/video_player.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  VideoPlayerController? controllerVideo;
  AudioPlayer? controllerAudio;
  TextEditingController mensaje = TextEditingController(text: '');
  File? imagen_to_upload;
  File? video_to_upload;
  File? audio_to_upload;
  bool isAudioPlaying = false;
  bool? uploaded;
  bool? uploadedV;
  bool? uploadA;

  @override
  void dispose() {
    super.dispose();
    controllerVideo?.dispose();
    controllerAudio?.dispose();
  }

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
                if (imagen_to_upload != null) Image.file(imagen_to_upload!),
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
                if (audio_to_upload != null)
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
                        onPressed: () async {
                          final imagen = await getImage();
                          setState(() {
                            imagen_to_upload = File(imagen!.path);
                          });
                        },
                        icon: const Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: IconButton(
                        onPressed: () async {
                          if (controllerVideo != null &&
                              controllerVideo!.value.isInitialized) {
                            VideoPlayer(controllerVideo!);
                          } else {
                            // Mostrar un indicador de carga u otro mensaje mientras el video se está inicializando
                            CircularProgressIndicator();
                          }
                          final video = await getVideo();
                          setState(() {
                            controllerVideo?.dispose();
                            video_to_upload = File(video!.path);
                            controllerVideo =
                                VideoPlayerController.file(File(video.path));
                          });
                          await controllerVideo!.initialize();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.video_camera_back_outlined,
                          size: 40,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: IconButton(
                          onPressed: () async {
                            final audio = await getAudio();
                            setState(() {
                              controllerAudio?.dispose();
                              audio_to_upload = File(audio!.path);
                              controllerAudio = AudioPlayer();
                            });
                            if (audio_to_upload != null) {
                              String audioPath = audio_to_upload!.path;
                              controllerAudio!.play(UrlSource(audioPath));
                              setState(() {
                                isAudioPlaying = true;
                              });
                            }
                          },
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
                        onPressed: () async {
                          if (imagen_to_upload != null) {
                            uploaded = await uploadImage(imagen_to_upload!);
                             ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'El archivo se envio correctamente')));
                          }
                          if (video_to_upload != null) {
                            uploadedV = await uploadVideo(video_to_upload!);
                             ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'El archivo se envio correctamente')));
                          }
                          if (audio_to_upload != null) {
                            uploadA = await uploadAudio(audio_to_upload!);
                             ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'El archivo se envio correctamente')));
                          }
                          return;
                        },
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
