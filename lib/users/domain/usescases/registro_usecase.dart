import '../entities/user.dart';
import '../repositories/user_repository.dart';

class RegisterUser {
  final Register register;
  RegisterUser(this.register);
  
  Future<User> execute() async {
    return await register.post();
  }
}
