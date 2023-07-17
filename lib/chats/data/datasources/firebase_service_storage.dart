import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatchat/users/data/datasources/fierebase_service_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/chat.dart';

abstract class FirebaseServiceStorage {
  Future<String?> uploadFiles(String uidChat, String emisorId,
      String receptorId, String nameFile, File file, int tipo);
  Future<List<Map<String, dynamic>>> getChats();
  Future<String?> searchChat(String idReceptor);
  Future<void> enviarMensajeTexto(
      String uidChat, String emisorId, String receptorId, String mensajeText);
  Future<List<Map<String, dynamic>>> getMensajes(String uidMensajes);
  Future<void> enviarUbicacion(
      String uidChat, String emisorId, String receptorId, GeoPoint ubicacion);
}

class FirebaseServiceStorageImpl implements FirebaseServiceStorage {
  final FirebaseStorage storage;
  PhoneAuthRepository? userRepository;

  FirebaseServiceStorageImpl({required this.storage});

  @override
  Future<String?> uploadFiles(String uidChat, String emisorId,
      String receptorId, String nameFile, File file, int tipo) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Reference ref = storage.ref().child(nameFile);
    final UploadTask uploadTask = ref.putFile(file);
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
    final url = await snapshot.ref.getDownloadURL();
    if (tipo == 0) {
      db.collection('chats').doc(uidChat).collection('mensajes').add({
        'emisorId': emisorId,
        'receptorId': receptorId,
        'timestamp': FieldValue.serverTimestamp(),
        'urlimg': url.toString()
      });
    }
    if (tipo == 1) {
      db.collection('chats').doc(uidChat).collection('mensajes').add({
        'emisorId': emisorId,
        'receptorId': receptorId,
        'timestamp': FieldValue.serverTimestamp(),
        'videoUrl': url.toString()
      });
    }
    if (tipo == 2) {
      db.collection('chats').doc(uidChat).collection('mensajes').add({
        'emisorId': emisorId,
        'receptorId': receptorId,
        'timestamp': FieldValue.serverTimestamp(),
        'audioUrl': url.toString()
      });
    }
    if (tipo == 3) {
      db.collection('chats').doc(uidChat).collection('mensajes').add({
        'emisorId': emisorId,
        'receptorId': receptorId,
        'timestamp': FieldValue.serverTimestamp(),
        'pdfUrl': url.toString()
      });
    }
    return url;
  }

  Future<void> enviarMensajeTexto(String uidChat, String emisorId,
      String receptorId, String mensajeText) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('chats').doc(uidChat).collection('mensajes').add({
      'emisorId': emisorId,
      'receptorId': receptorId,
      'timestamp': FieldValue.serverTimestamp(),
      'contenido': mensajeText
    });
  }

  @override
  Future<void> enviarUbicacion(String uidChat, String emisorId,
      String receptorId, GeoPoint ubicacion) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      await db.collection('chats').doc(uidChat).collection('mensajes').add({
        'emisorId': emisorId,
        'receptorId': receptorId,
        'timestamp': FieldValue.serverTimestamp(),
        'location': ubicacion
      });
      print('Ubicación guardada en Firebase');
    } catch (error) {
      print('Error al guardar la ubicación o al obtenerla desde Firebase: $error');
    
    }
  }

  Future<List<Map<String, dynamic>>> getChats() async {
    try {
      print('FirebaseStorageGETCHATSTry');
      String userId = 'AztlXcqdaW35CkxesKDz';
      List<Map<String, dynamic>> chats = [];
      FirebaseFirestore db = FirebaseFirestore.instance;
      // final userId = await userRepository
      //     ?.listaUsers(); // Obtén el identificador del usuario actual
      print('FirebaseStorageGETCHATS2222');
      QuerySnapshot querySnapshot = await db
          .collection('chats')
          .where('idEmisor', isEqualTo: userId)
          .get();
      print('prueba: wwwwwwwwwwwwwwwwwwwwww');
      // Obtiene los chats donde eres el emisor
      for (var element in querySnapshot.docs) {
        print('FirebaseStorageGETCHATS333333');
        String uidChat = element.id;
        final Map<String, dynamic> data =
            element.data() as Map<String, dynamic>;
        final receptorId = data['idReceptor'];
        var collectionUser = db.collection('users').doc(receptorId);
        DocumentSnapshot userSnapshot = await collectionUser.get();
        if (userSnapshot.exists) {
          print('hellooo');
          String phone;
          String username;
          var userData = userSnapshot.data() as Map<String, dynamic>;
          phone = userData['phone'];
          username = userData['user'];
          CollectionReference users =
              db.collection('users').doc(userId).collection('contactos');
          Query queryContactos = users.where('phone', isEqualTo: phone);
          QuerySnapshot querySnapshot = await queryContactos.get();
          if (querySnapshot.docs.isEmpty) {
            print('No se encontraron usuarios con ese número de teléfono');
          } else {
            for (var element in querySnapshot.docs) {
              print('si hay usuarios con ese numero en tus contactos');
              final Map<String, dynamic> data =
                  element.data() as Map<String, dynamic>;
              final chat = {
                'idReceptor': receptorId,
                'apodo': data['apodo'],
                'username': username,
                'uidChat': uidChat
              };
              chats.add(chat);
            }
          }
        } else {
          print('entra en el else');
        }
      }
      print('FirebaseStorageGETCHATS44444');
      querySnapshot = await db
          .collection('chats')
          .where('idReceptor', isEqualTo: userId)
          .get();
      for (var element in querySnapshot.docs) {
        print('FirebaseStorageGETCHATS55555555');
        String uidChat = element.id;
        print('Holaa');
        final Map<String, dynamic> data =
            element.data() as Map<String, dynamic>;
        final emisorId = data['idEmisor'];
        var collectionUser = db.collection('users').doc(emisorId);
        DocumentSnapshot userSnapshot = await collectionUser.get();
        if (userSnapshot.exists) {
          print('este receptor esta registrado');
          String phone;
          String username;
          var userData = userSnapshot.data() as Map<String, dynamic>;
          phone = userData['phone'];
          username = userData['user'];
          CollectionReference users =
              db.collection('users').doc(userId).collection('contactos');
          Query queryContactos = users.where('phone', isEqualTo: phone);
          QuerySnapshot querySnapshot = await queryContactos.get();
          if (querySnapshot.docs.isEmpty) {
            print('No se encontraron usuarios con ese número de teléfono');
          } else {
            for (var element in querySnapshot.docs) {
              print('si hay usuarios con ese numero en tus contactos');
              final Map<String, dynamic> data =
                  element.data() as Map<String, dynamic>;
              final chat = {
                'idReceptor': emisorId,
                'apodo': data['apodo'],
                'username': username,
                'uidChat': uidChat
              };
              chats.add(chat);
            }
          }

          // Utiliza el nombre de usuario según sea necesario
        } else {
          // No se encontró el documento del usuario
        }
      }
      // Agrega los chats donde eres el receptor a la lista
      print(chats);
      return chats;
    } catch (error, stackTrace) {
      print('FirebaseStorageGETCHATS');
      print('StackTrace: $stackTrace');
      print('Error al obtener los chats: $error');
      return [];
    }
  }

  @override
  Future<String?> searchChat(String idReceptor) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    // final userId = await userRepository?.listaUsers();
    const userId = 'AztlXcqdaW35CkxesKDz';
    QuerySnapshot querySearch = await db
        .collection('chats')
        .where('idEmisor', isEqualTo: userId)
        .where('idReceptor', isEqualTo: idReceptor)
        .get();

    if (querySearch.docs.isNotEmpty) {
      print('Se encontro el chat');
      return querySearch.docs[0].id;
    } else {
      //aqui tengo que crear el chat y retornar su id
      String idMensaje;
      DocumentReference nuevoChat = await db
          .collection('chats')
          .add({'idEmisor': userId, 'idReceptor': idReceptor});
      print('Se creo un nuevo chat');
      return nuevoChat.id;
    }
  }

  Future<List<Map<String, dynamic>>> getMensajes(String uidMensajes) async {
    // String? miuserid = await userRepository?.miUserId();
    // print('respuesta de userrepository id');
    // print(miuserid);
    String? miuserid = 'AztlXcqdaW35CkxesKDz';
    List<Map<String, dynamic>> mensajesObtenidos = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      CollectionReference mensajes =
          db.collection('chats').doc(uidMensajes).collection('mensajes');
      QuerySnapshot queryMensajes = await mensajes.orderBy('timestamp').get();
      for (var element in queryMensajes.docs) {
        final Map<String, dynamic> data =
            element.data() as Map<String, dynamic>;
        final mensaje = {
          'idReceptor': data['receptorId'],
          'idEmisor': data['emisorId'],
          'contenido': data['contenido'],
          'urlimg': data['urlimg'],
          'videoUrl': data['videoUrl'],
          'audioUrl': data['audioUrl'],
          'pdfUrl': data['pdfUrl'],
          'location': data['location'],
          'miId': miuserid
        };
        mensajesObtenidos.add(mensaje);
      }
      print('mensajes encontrados');
      print(mensajesObtenidos.length);
      return mensajesObtenidos;
    } catch (e) {
      print('No hay mensajes');
      return [];
    }
  }
}
