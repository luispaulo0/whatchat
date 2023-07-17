import 'package:whatchat/users/data/datasources/fierebase_service_register.dart';
import 'package:whatchat/users/domain/entities/user.dart';
import 'package:whatchat/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements Register {
  final PhoneAuthRepository phoneAuthRepository;
  UserRepositoryImpl({required this.phoneAuthRepository});

  Future<String> post(User user) async {
    final String numer = await _verifyNumber(user);
    return 'se registro el numero';
  }

  Future<String> _verifyNumber(User user) async {
    if (user.phone != null) {
      phoneAuthRepository.verifyPhoneNumber(user.username,user.phone);
      return 'correcto';
    }
    return 'error';
  }

  Future<String?> sms(String sms) async {
    String? users;
    users = await _verifySms(sms);
    return users;
  }

  Future<String?> _verifySms(String sms) async {
    String? users;
    if (sms != null) {
      users = await phoneAuthRepository.signInWithPhoneNumber(sms);
      return users;
    } else {
      print("no se pudo verificar el número");
      return null;
    }
  }

  @override
  Future<String?> exist(String phone) async {
    String? existe;
    try {
      existe = await phoneAuthRepository.existUser(phone);
      return existe;
    } catch (error) {
      print('error obtenido existencia user:$error');
      return null;
    }
  }
}
