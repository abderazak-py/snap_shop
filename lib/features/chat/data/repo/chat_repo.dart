import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

abstract class ChatRepository {
  Future<ChatMessage> send(String prompt);
  Future<List<ChatMessage>> load(String chatId);
  Future<void> save(String chatId, List<ChatMessage> history);
}
