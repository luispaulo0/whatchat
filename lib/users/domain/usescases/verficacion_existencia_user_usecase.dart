import 'package:whatchat/users/domain/repositories/user_repository.dart';

class VerificacionExistenciaUserUserCase {
  final Register register;
  VerificacionExistenciaUserUserCase({required this.register});
  Future<String?> execute(String phone) async {
    return await register.exist(phone);
  }
}
