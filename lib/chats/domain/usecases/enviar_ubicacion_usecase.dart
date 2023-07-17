import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatchat/chats/domain/repositories/chat_repository.dart';

class EnviarUbicacionUseCase {
  final ChatRepository repository;

  EnviarUbicacionUseCase({required this.repository});

  Future<void> execute(String uidChat, String emisorId, String receptorId,
      GeoPoint ubicacion) async {
    return await repository.enviarUbicacion(
        uidChat, emisorId, receptorId, ubicacion);
  }
}
