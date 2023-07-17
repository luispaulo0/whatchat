import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatchat/chats/domain/entities/chat.dart';
import 'package:whatchat/chats/domain/entities/mensaje.dart';

abstract class ChatRepository {
  Future<String> enviarMensaje(
      String uidChat, String emisorId, String receptorId, Mensaje mensaje);
  Future<List<Map<String, dynamic>>> getChats();
  Future<String?> searchChat(String idReceptor);
  Future<List<Map<String, dynamic>>> getMensajes(String uidMensajes);
  Future<void> enviarMensajeTexto(
      String uidChat, String emisorId, String receptorId, Mensaje mensaje);
  Future<void> enviarUbicacion(String uidChat, String emisorId,
      String receptorId, GeoPoint ubicacion);
}
