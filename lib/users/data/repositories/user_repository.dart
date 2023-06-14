import 'package:whatchat/users/data/datasources/fierebase_service_register.dart';
import 'package:whatchat/users/domain/entities/user.dart';
import 'package:whatchat/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements Register {
  final PhoneAuthRepository phoneAuthRepository;
  UserRepositoryImpl({required this.phoneAuthRepository});

  Future<String> post(User user) async {
    final String numer = await _verifyNumber(user.phone);
    return 'se registro el numero';
  }

  Future<String> _verifyNumber(String number) async {
    if (number != null) {
      phoneAuthRepository.verifyPhoneNumber(number);
      return 'correcto';
    }
    return 'error';
  }
}
