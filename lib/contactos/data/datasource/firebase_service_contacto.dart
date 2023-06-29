import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatchat/contactos/dominio/entities/contacto.dart'
    as contactoentitie;
import 'package:whatchat/users/data/datasources/fierebase_service_register.dart';
import '../../../users/domain/entities/user.dart' as userEntitie;

abstract class FirebaseServiceContacto {
  Future<void> searchUser(String phone, String apodo);
  Future<List<Map<String, dynamic>>> getContactos();
}

class FirebaseServiceContactoImpl implements FirebaseServiceContacto {
  FirebaseFirestore db = FirebaseFirestore.instance;
  PhoneAuthRepository? userRepository;
  List contactos = [];

  FirebaseServiceContactoImpl({required this.db});

  @override
  Future<void> searchUser(String phone, String apodo) async {
    // String? uid;
    String uid = 'AztlXcqdaW35CkxesKDz';
    CollectionReference collectionReferenceUsers = db.collection('users');
    Query query = collectionReferenceUsers.where('phone', isEqualTo: phone);

    query.get().then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isEmpty) {
        print('No se encontraron usuarios con ese número de teléfono');
      }
      // uid = await userRepository?.listaUsers();
      querySnapshot.docs.forEach((DocumentSnapshot elemenet) async {
        db
            .collection('users')
            .doc(uid)
            .collection('contactos')
            .add({'apodo': apodo, 'phone': elemenet['phone']});
      });
    }).catchError((error) {
      print('Error obteniendo usuarios: $error');
    });
  }

  Future<List<Map<String, dynamic>>> getContactos() async {
    try {
      String uid = 'AztlXcqdaW35CkxesKDz';
      List<Map<String, dynamic>> contactosM =
          []; // Inicializa la lista con una lista vacía
      CollectionReference users =
          db.collection('users').doc(uid).collection('contactos');
      QuerySnapshot queryContactos = await users.get();
      for (var element in queryContactos.docs) {
        final Map<String, dynamic> data =
            element.data() as Map<String, dynamic>;
        final contac = {'apodo': data['apodo'], 'phone': data['phone'], 'uidContacto':element.id};
        contactosM.add(contac);
      }

      return contactosM;
    } catch (error) {
      print('Este es el maldito error $error');
      return [];
    }
  }
}
