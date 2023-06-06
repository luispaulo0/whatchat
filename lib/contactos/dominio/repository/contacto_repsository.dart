import '../entities/contacto.dart';

abstract class NuevoContacto {
  Future<Contacto> post();
}

abstract class BorrarContacto {
  Future<int> delete();
}
