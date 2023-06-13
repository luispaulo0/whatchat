import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebaseServiceStorage {
  Future<String> uploadFiles(String collection, File file);
}

class FirebaseServiceStorageImpl implements FirebaseServiceStorage {
  final FirebaseStorage storage;

  FirebaseServiceStorageImpl({required this.storage});

  Future<String> uploadFiles(String collection, File file) async {
    
    Reference ref = storage.ref().child(collection);
    final UploadTask uploadTask = ref.putFile(file);
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
    final url = snapshot.ref.getDownloadURL();
    return url;
  }
}
