import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart' show ChatMessage;
import '../../data/repo/chat_repo.dart';

class SendMessageUsecase {
  final ChatRepository repository;

  SendMessageUsecase(this.repository);

  Future<ChatMessage> excute(String prompt) {
    return repository.send(prompt);
  }
}
