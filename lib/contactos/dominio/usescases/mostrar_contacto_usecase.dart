import 'package:whatchat/contactos/dominio/repository/contacto_repsository.dart';
import '../entities/contacto.dart';

class MostrarContactoUseCase {
  final ContactoRepositories mostrarContacto;

  MostrarContactoUseCase({required this.mostrarContacto});

  Future<List?> execute() async {
    return await mostrarContacto.show();
  }
}
