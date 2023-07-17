import 'package:flutter/material.dart';
import 'package:whatchat/chats/domain/repositories/chat_repository.dart';

class ObtenerChatsUseCase {
  final ChatRepository repository;

  ObtenerChatsUseCase({required this.repository});

  Future<List<Map<String, dynamic>>> execute() async {
    return await repository.getChats();
  }
}
