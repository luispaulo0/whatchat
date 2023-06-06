import '../entities/user.dart';

abstract class Register {
  Future<User> post();
}


