import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatchat/users/data/datasources/fierebase_service_register.dart';
import 'package:whatchat/users/data/repositories/user_repository.dart';
import 'package:whatchat/users/domain/usescases/registro_usecase.dart';
import 'package:whatchat/users/domain/usescases/verficacion_existencia_user_usecase.dart';

class UseCasesConfigUser {
  RegisterUser? registerUser;
  SmsValidation? smsValidation;
  VerificacionExistenciaUserUserCase? verificacion;

  PhoneAuthRepository? phoneAuthRepository;
  UserRepositoryImpl? userRepositoryImpl;

  UseCasesConfigUser(this.phoneAuthRepository) {
    userRepositoryImpl =
        UserRepositoryImpl(phoneAuthRepository: phoneAuthRepository!);
    registerUser = RegisterUser(register: userRepositoryImpl!);
    smsValidation = SmsValidation(register: userRepositoryImpl!);
    verificacion =
        VerificacionExistenciaUserUserCase(register: userRepositoryImpl!);
  }
}
