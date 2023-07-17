import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatchat/chats/data/datasources/firebase_service_storage.dart';
import 'package:whatchat/chats/domain/entities/mensaje.dart';
import 'package:whatchat/chats/domain/repositories/chat_repository.dart';

class MensajeRepositoryImpl implements ChatRepository {
  final FirebaseServiceStorage firebaseServiceStorage;

  MensajeRepositoryImpl({required this.firebaseServiceStorage});

  @override
  Future<void> enviarUbicacion(String uidChat, String emisorId,
      String receptorId, GeoPoint ubicacion) async {
    return firebaseServiceStorage.enviarUbicacion(
        uidChat, emisorId, receptorId, ubicacion);
  }

  Future<String> enviarMensaje(String uidChat, String emisorId,
      String receptorId, Mensaje mensaje) async {
    final String? imgUrl = await _uploadFiles(
        uidChat, emisorId, receptorId, mensaje.imagenFile, 0);

    final String? videoUrl =
        await _uploadFiles(uidChat, emisorId, receptorId, mensaje.videoFile, 1);

    final String? audioUrl =
        await _uploadFiles(uidChat, emisorId, receptorId, mensaje.audioFile, 2);
    final String? pdfUrl =
        await _uploadFiles(uidChat, emisorId, receptorId, mensaje.pdfFile, 3);
    return 'Archivo enviado exitosamente';
  }

  Future<void> enviarMensajeTexto(String uidChat, String emisorId,
      String receptorId, Mensaje mensaje) async {
    print('data repository mensaje-------------------------');
    final String mensajeText = mensaje.text.toString();
    print(mensajeText);
    await firebaseServiceStorage.enviarMensajeTexto(
        uidChat, emisorId, receptorId, mensajeText);
  }

  @override
  Future<List<Map<String, dynamic>>> getChats() async {
    print('getChatsREPOSITORY');
    List<Map<String, dynamic>> chatsList = [];
    chatsList = await firebaseServiceStorage.getChats();
    return chatsList;
  }

  Future<String?> _uploadFiles(String uidChat, String emisorId,
      String receptorId, File? file, int tipo) async {
    if (file != null) {
      final fileName =
          'mensajes/${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}';
      return firebaseServiceStorage.uploadFiles(
          uidChat, emisorId, receptorId, fileName, file, tipo);
    }
    return null;
  }

  @override
  Future<String?> searchChat(String idReceptor) async {
    String? idChat = await firebaseServiceStorage.searchChat(idReceptor);
    return idChat;
  }

  Future<List<Map<String, dynamic>>> getMensajes(String uidMensaje) async {
    print('repository get mensajes');
    List<Map<String, dynamic>> mensajes = [];
    mensajes = await firebaseServiceStorage.getMensajes(uidMensaje);
    return mensajes;
  }
}
