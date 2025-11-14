import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

abstract class ChatRepository {
  Future<ChatMessage> send(String prompt);
  Future<List<ChatMessage>> load();
  Future<void> save(List<ChatMessage> history);
}
