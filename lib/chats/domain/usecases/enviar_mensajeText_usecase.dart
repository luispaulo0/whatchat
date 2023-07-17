import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:whatchat/chats/domain/repositories/chat_repository.dart';

import '../entities/mensaje.dart';

class EnviarMensajeText {
  final ChatRepository repository;

  EnviarMensajeText({required this.repository});

  Future<void> execute(
      String uidChat, String emisorId, String receptorId, Mensaje mensaje) {
    return repository.enviarMensajeTexto(
        uidChat, emisorId, receptorId, mensaje);
  }
}
