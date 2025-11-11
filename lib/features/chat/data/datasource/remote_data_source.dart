import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

class ChatRemoteDataSource {
  ChatRemoteDataSource(this.provider);
  final FirebaseProvider provider;

  Future<ChatMessage> send(String prompt) async {
    final stream = provider.sendMessageStream(
      prompt,
    ); // Stream of chunks/tokens
    final buffer = StringBuffer();
    await for (final chunk in stream) {
      // If chunk is a typed object, extract text; if it’s just String, append directly.
      buffer.write(chunk.toString());
    }
    final msg = ChatMessage.llm()
      ..text = buffer.toString(); // single final message
    return msg;
  }
}
