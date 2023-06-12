import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<bool> uploadAudio(File audio) async {
  final String nameFile = audio.path.split('/').last;

  Reference ref = storage.ref().child('audios').child(nameFile);
  final UploadTask uploadTask = ref.putFile(audio);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);

  if (snapshot.state == TaskState.success) {
    return true;
  } else {
    return false;
  }
}
