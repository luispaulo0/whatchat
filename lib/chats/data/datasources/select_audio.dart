import 'dart:io';

import 'package:file_picker/file_picker.dart';
Future<File?> getAudio() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['mp3'],
  );

  if (result != null) {
    File audio = File(result.files.single.path!);
    return audio;
  } else {
    return null;
  }
}
