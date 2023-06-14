import 'dart:io';
import 'package:whatchat/users/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required int id, required String phone, required String username})
      : super(id: id, phone: phone, username: username);
}
