import 'dart:io';
import 'package:whatchat/chats/data/datasources/firebase_service_storage.dart';
import 'package:whatchat/chats/domain/entities/mensaje.dart';
import 'package:whatchat/chats/domain/repositories/chat_repository.dart';

class MensajeRepositoryImpl implements ChatRepository {
  final FirebaseServiceStorage firebaseServiceStorage;

  MensajeRepositoryImpl({required this.firebaseServiceStorage});

  Future<String> enviarMensaje(Mensaje mensaje) async {
    final String? imgUrl = await _uploadFiles(mensaje.imagenFile);
    final String? vidUrl = await _uploadFiles(mensaje.videoFile);
    final String? audUrl = await _uploadFiles(mensaje.audioFile);

    final mensajeDatos = {
      'imgUrl': mensaje.imagenFile,
      'vidUrl': mensaje.videoFile,
      'audUrl': mensaje.audioFile
    };

    return 'Archivo enviado exitosamente';
  }

  Future<String?> _uploadFiles(File? file) async {
    if (file != null) {
      final String nameFile = file.path.split('/').last;
      final collection = 'mensajes/$nameFile';
      return firebaseServiceStorage.uploadFiles(collection, file);
    }
    return null;
  }
}
