import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart' show ChatMessage;
import '../../data/repo/chat_repo.dart';

class LoadMessagesUsecase {
  final ChatRepository repository;

  LoadMessagesUsecase(this.repository);

  Future<List<ChatMessage>> execute() {
    return repository.load();
  }
}
