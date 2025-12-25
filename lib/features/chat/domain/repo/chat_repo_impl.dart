import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart' show ChatMessage;
import '../../data/datasource/local_data_source.dart';
import '../../data/datasource/remote_data_source.dart';
import '../../data/repo/chat_repo.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ChatLocalDataSource localDataSource;

  ChatRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<ChatMessage> send(String prompt) {
    return remoteDataSource.send(prompt);
  }

  @override
  Future<List<ChatMessage>> load() {
    return localDataSource.load();
  }

  @override
  Future<void> save(List<ChatMessage> history) {
    return localDataSource.save(history);
  }
}
