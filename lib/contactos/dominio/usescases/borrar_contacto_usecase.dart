import '../repository/contacto_repsository.dart';

class DeleteContact {
  final BorrarContacto borrarContacto;
  DeleteContact(this.borrarContacto);

  Future<int> execute() async {
    return await borrarContacto.delete();
  }
}
