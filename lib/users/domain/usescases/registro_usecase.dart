import '../entities/user.dart';
import '../repositories/user_repository.dart';

class RegisterUser {
  final Register register;
  RegisterUser(this.register);
  
  Future<String> execute(User user) async {
    return await register.post(user);
  }
}
