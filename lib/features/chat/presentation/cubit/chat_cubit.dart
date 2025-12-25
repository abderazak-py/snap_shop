import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import '../../domain/usecases/load_messages_usecase.dart';
import '../../domain/usecases/save_messages_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final FirebaseProvider provider;
  final LoadMessagesUsecase loadMessages;
  final SaveMessagesUsecase saveMessages;
  late final VoidCallback _providerListener;
  ChatCubit({
    required this.provider,
    required this.loadMessages,
    required this.saveMessages,
  }) : super(ChatInitial()) {
    // Listen for LlmChatView-driven updates, auto-save on changes
    _providerListener = () {
      saveMessages.execute(provider.history.toList());
      emit(
        ChatSuccess(provider.history.toList()),
      ); // Sync UI if you want live updates
    };
    provider.addListener(_providerListener);
  }
  Future<void> loadChat() async {
    emit(ChatLoading());
    try {
      final loaded = await loadMessages.execute();
      provider.history = loaded.toList(); // Hydrate before building UI
      emit(ChatSuccess(loaded.toList()));
    } catch (e) {
      emit(ChatFailure("Failed to load messages"));
    }
  }

  @override
  Future<void> close() {
    provider.removeListener(_providerListener);
    return super.close();
  }
}
