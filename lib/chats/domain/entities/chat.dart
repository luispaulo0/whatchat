import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Chat {
  final String mensaje;
  final String date;
  final XFile file;
  final File audio;

  Chat({
    required this.mensaje,
    required this.date,
    required this.file,
    required this.audio
  });
}
