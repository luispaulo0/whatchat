import '../entities/user.dart';
import '../repositories/user_repository.dart';

class RegisterUser {
  final Register register;
  RegisterUser({required this.register});

  Future<String?> execute(User user) async {
    return await register.post(user);
  }
}

class SmsValidation {
  final Register register;
  SmsValidation({required this.register});

  Future<bool> execute(String sms) async {
    return await register.sms(sms);
  }
}
