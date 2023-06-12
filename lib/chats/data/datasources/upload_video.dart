import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<bool> uploadVideo(File video) async {
  final String nameFile = video.path.split('/').last;

  Reference ref = storage.ref().child('videos').child(nameFile);
  final UploadTask uploadTask = ref.putFile(video);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);

  if (snapshot.state == TaskState.success) {
    return true;
  } else {
    return false;
  }
}
