import 'package:whatchat/chats/domain/repositories/chat_repository.dart';

class SearchChatUseCase {
  final ChatRepository repository;

  SearchChatUseCase({required this.repository});

  Future<String?> execute(String idReceptor) async {
    return repository.searchChat(idReceptor);
  }
}
