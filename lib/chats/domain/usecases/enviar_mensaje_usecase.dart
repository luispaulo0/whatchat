import 'package:whatchat/chats/domain/repositories/chat_repository.dart';
import '../entities/mensaje.dart';

class EnviarMensajeUseCase {
  final ChatRepository repository;

  EnviarMensajeUseCase({required this.repository});

  Future<String> execute(String uidChat, String emisorId,String receptorId,Mensaje mensaje) {
    return repository.enviarMensaje(uidChat,emisorId,receptorId,mensaje);
  }
}