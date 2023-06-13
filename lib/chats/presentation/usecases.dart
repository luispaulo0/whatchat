import 'package:whatchat/chats/data/datasources/firebase_service_storage.dart';
import 'package:whatchat/chats/data/repositories/mensaje_repository.dart';
import 'package:whatchat/chats/domain/repositories/chat_repository.dart';
import 'package:whatchat/chats/domain/usecases/enviar_mensaje_usecase.dart';

class UseCases {
  EnviarMensajeUseCase? enviarMensajeUseCase;
  MensajeRepositoryImpl? mensajeRepository;
  FirebaseServiceStorage? firebaseServiceStorage;

  UseCases(this.firebaseServiceStorage) {
    mensajeRepository =
        MensajeRepositoryImpl(firebaseServiceStorage: firebaseServiceStorage!);
    enviarMensajeUseCase = EnviarMensajeUseCase(repository: mensajeRepository!);
  }
}
