import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<bool> uploadImage(File image) async {
  final String nameFile = image.path.split('/').last;

  Reference ref = storage.ref().child('images').child(nameFile);
  final UploadTask uploadTask = ref.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);

  if (snapshot.state == TaskState.success) {
    return true;
  } else {
    return false;
  }
}
