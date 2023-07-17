import 'dart:io';

class Mensaje {
  final String? text;
  final File? imagenFile;
  final File? videoFile;
  final File? audioFile;
  final File? pdfFile;

  Mensaje({this.imagenFile, this.audioFile, this.videoFile, this.text, this.pdfFile});
}
