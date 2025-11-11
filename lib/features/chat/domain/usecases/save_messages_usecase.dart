import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart' show ChatMessage;
import 'package:snap_shop/features/chat/data/repo/chat_repo.dart';

class SaveMessagesUsecase {
  final ChatRepository repository;

  SaveMessagesUsecase(this.repository);

  Future<void> execute(String chatId, List<ChatMessage> history) {
    return repository.save(chatId, history);
  }
}
