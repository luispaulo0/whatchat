import '../entities/user.dart';

abstract class Register {
  Future<String> post(User user);
}


