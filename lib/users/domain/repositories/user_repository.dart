import '../entities/user.dart';

abstract class Register {
  Future<String> post(User user);
  Future<bool> sms(String sms);
  Future<bool> exist(String phone);
}
