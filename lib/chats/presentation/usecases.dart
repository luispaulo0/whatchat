import 'package:whatchat/chats/data/datasources/firebase_service_storage.dart';
import 'package:whatchat/chats/data/repositories/mensaje_repository.dart';
import 'package:whatchat/chats/domain/repositories/chat_repository.dart';
import 'package:whatchat/chats/domain/usecases/enviar_mensaje_usecase.dart';
import 'package:whatchat/contactos/data/datasource/firebase_service_contacto.dart';
import 'package:whatchat/contactos/data/repository/contacto_repository.dart';
import 'package:whatchat/contactos/dominio/repository/contacto_repsository.dart';
import 'package:whatchat/contactos/dominio/usescases/agregar_contacto_usecase.dart';
import 'package:whatchat/contactos/dominio/usescases/mostrar_contacto_usecase.dart';

class UseCases {
  FirebaseServiceStorage? firebaseServiceStorage;
  FirebaseServiceContacto? firebaseServiceContacto;

  EnviarMensajeUseCase? enviarMensajeUseCase;
  MostrarContactoUseCase? mostrarContacto;
  NewContac? nuevoContacto;

  MensajeRepositoryImpl? mensajeRepository;
  ContactoRepositoryImpl? contactoRepository;
  

  UseCases(this.firebaseServiceStorage, this.firebaseServiceContacto) {
    mensajeRepository =
        MensajeRepositoryImpl(firebaseServiceStorage: firebaseServiceStorage!);
    enviarMensajeUseCase = EnviarMensajeUseCase(repository: mensajeRepository!);
    contactoRepository = ContactoRepositoryImpl(
        firebaseServiceContacto: firebaseServiceContacto!);
    nuevoContacto = NewContac(nuevoContacto: contactoRepository!);
    mostrarContacto = MostrarContactoUseCase(mostrarContacto: contactoRepository!);
  }
}
