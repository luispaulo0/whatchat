import 'package:whatchat/contactos/data/datasource/firebase_service_contacto.dart';
import 'package:whatchat/contactos/dominio/entities/contacto.dart';
import 'package:whatchat/contactos/dominio/repository/contacto_repsository.dart';
import 'package:whatchat/users/data/datasources/fierebase_service_register.dart';

class ContactoRepositoryImpl implements ContactoRepositories {
  final FirebaseServiceContacto firebaseServiceContacto;
  ContactoRepositoryImpl({required this.firebaseServiceContacto});

  Future<void> post(String phone, String apodo) async {
    await firebaseServiceContacto.searchUser(phone, apodo);
  }

  Future<List<Map<String, dynamic>>> show() async {
    final List<Map<String, dynamic>>? contactos = await _getContactosR();
    return contactos ?? [];
  }

  Future<List<Map<String, dynamic>>?> _getContactosR() async {
    try {
      List<Map<String, dynamic>> contactos = [];
      contactos = await firebaseServiceContacto.getContactos();
      return contactos;
    } catch (e) {
      print(e);
      return null;
    }
  }

}
