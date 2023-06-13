import 'dart:io';

class Mensaje {
  final File? imagenFile;
  final File? videoFile;
  final File? audioFile;

  Mensaje({
    this.imagenFile,
    this.audioFile,
    this.videoFile
  });
}
