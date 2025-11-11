import 'dart:convert';

import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:get_storage/get_storage.dart';

class ChatLocalDataSource {
  ChatLocalDataSource(this.store);
  final GetStorage store;

  String _key(String id) => 'chat:$id';

  Future<List<ChatMessage>> load(String chatId) async {
    final data = store.read<String>(_key(chatId));
    if (data == null || data.isEmpty) return [];
    final List raw = jsonDecode(data);
    print(
      'start LOADINGGGGGGG --${raw.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>)).toList()}End ',
    );
    return raw
        .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
        .toList(); // [web:15]
  }

  Future<void> save(String chatId, List<ChatMessage> history) async {
    final raw = history.map((m) => m.toJson()).toList(); // [web:15]
    await store.write(_key(chatId), jsonEncode(raw));
    print('Mesage sAAAAAAAAAAAAAved');
    print(store.read<String>(_key(chatId)));
    // [web:29]
  }
}
