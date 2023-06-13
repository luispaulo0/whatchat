import 'dart:io';
import 'package:whatchat/chats/domain/entities/mensaje.dart';

class MensajeModel extends Mensaje {
  MensajeModel({
    File? imagenFile,
    File? videoFile,
    File? audioFile,
  }) : super(
            imagenFile: imagenFile,
            videoFile: videoFile,
            audioFile: audioFile);
  factory MensajeModel.fromJson(Map<String, dynamic> json) {
    return MensajeModel(
        imagenFile: json['imagenFile'],
        videoFile: json['videoFile'],
        audioFile: json['audioFile']);
  }
  Map<String, dynamic> toJson() {
    return {
      'imagenFile': imagenFile,
      'videoFile': videoFile,
      'audioFile': audioFile
    };
  }
}
