import 'package:flutter/material.dart';
import 'package:whatchat/chats/presentation/usecases.dart';

class NuevoContactoProvider extends ChangeNotifier {
  final UseCases useCases;
  String phone = '';
  String apodo = '';
  bool exist = false;
  NuevoContactoProvider({required this.useCases});
  
  void setPhone(String value) {
    phone = value;
    notifyListeners();
  }

  void setApodo(String value) {
    apodo = value;
    notifyListeners();
  }

  Future<void> guardarContacto() async {
    bool? respuesta;
    try {
      print(phone);
      respuesta = await useCases.nuevoContacto?.execute(phone, apodo);
      if (respuesta == true) {
        exist = true;
        notifyListeners();
      } else {
        exist = false;
        notifyListeners();
      }
    } catch (error) {
      print('Este es el error a la hora de guardar un contacto$error');
    }
  }
}
