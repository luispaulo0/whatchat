import 'package:whatchat/contactos/dominio/entities/contacto.dart';
import '../../../users/domain/entities/user.dart';

class ContactoModel extends Contacto {
  ContactoModel({String? apodo, User? user}) : super(apodo: apodo, user: user);
  factory ContactoModel.fromJson(Map<String, dynamic> json) {
    return ContactoModel(apodo: json['apodo'], user: json['user']);
  }
  Map<String, dynamic> toJson() {
    return {'apodo': apodo, 'user': user};
  }
}
