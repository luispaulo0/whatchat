import 'dart:io';
import 'package:whatchat/users/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required String phone, required String username})
      : super(phone: phone, username: username);
}
