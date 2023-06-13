import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:whatchat/chats/domain/entities/chat.dart';
import 'package:whatchat/chats/domain/entities/mensaje.dart';

abstract class ChatRepository {
  Future<String> enviarMensaje(Mensaje mensaje);
}
