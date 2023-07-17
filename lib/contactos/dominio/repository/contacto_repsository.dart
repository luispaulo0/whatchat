import 'package:whatchat/users/domain/entities/user.dart';

import '../entities/contacto.dart';

abstract class ContactoRepositories {
  Future<bool> post(String phone, String apodo);
  Future<List> show();
}

abstract class BorrarContacto {
  Future<int> delete();
}
