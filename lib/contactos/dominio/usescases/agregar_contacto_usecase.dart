import 'package:whatchat/contactos/dominio/entities/contacto.dart';
import '../repository/contacto_repsository.dart';

class NewContac {
  final ContactoRepositories nuevoContacto;

  NewContac({required this.nuevoContacto});

  Future<void> execute(String phone, String apodo) async {
    return await nuevoContacto.post(phone, apodo);
  }
}
