import '../entities/user.dart';

abstract class Register {
  Future<String> post(User user);
  Future<String?> sms(String sms);
  Future<String?> exist(String phone);
}
