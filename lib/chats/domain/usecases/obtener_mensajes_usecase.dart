import 'package:whatchat/chats/domain/repositories/chat_repository.dart';

class ObtenerMensajesUseCase {
  final ChatRepository repository;

  ObtenerMensajesUseCase({required this.repository});

  Future<List<Map<String, dynamic>>> execute(String uidMensajes) async {
    return await repository.getMensajes(uidMensajes);
  }
}
