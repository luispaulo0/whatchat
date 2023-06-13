import 'package:whatchat/chats/domain/repositories/chat_repository.dart';
import '../entities/mensaje.dart';

class EnviarMensajeUseCase {
  final ChatRepository repository;

  EnviarMensajeUseCase({required this.repository});

  Future<String> execute(Mensaje mensaje) {
    return repository.enviarMensaje(mensaje);
  }
}