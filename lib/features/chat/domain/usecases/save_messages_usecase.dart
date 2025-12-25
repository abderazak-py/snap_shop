import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart' show ChatMessage;
import '../../data/repo/chat_repo.dart';

class SaveMessagesUsecase {
  final ChatRepository repository;

  SaveMessagesUsecase(this.repository);

  Future<void> execute(List<ChatMessage> history) {
    return repository.save(history);
  }
}
