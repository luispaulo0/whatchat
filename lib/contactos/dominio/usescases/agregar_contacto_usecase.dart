import 'package:whatchat/contactos/dominio/entities/contacto.dart';
import '../repository/contacto_repsository.dart';


class NewContac {
  final NuevoContacto nuevoContacto;

  NewContac(this.nuevoContacto);
  Future<Contacto> execute() async {
    return await nuevoContacto.post();
  }
}
