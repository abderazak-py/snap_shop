import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/chat/domain/usecases/load_messages_usecase.dart';
import 'package:snap_shop/features/chat/domain/usecases/save_messages_usecase.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.chatId});
  final String chatId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final FirebaseProvider provider;
  late final LoadMessagesUsecase loadHistory;
  late final SaveMessagesUsecase saveHistory;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    provider = sl<FirebaseProvider>();
    loadHistory = sl<LoadMessagesUsecase>();
    saveHistory = sl<SaveMessagesUsecase>();
    _hydrate();
    provider.addListener(_onHistoryChanged);
  }

  Future<void> _hydrate() async {
    final history = await loadHistory.execute(widget.chatId);
    provider.history = history; // Set before build
    setState(() => _loading = false);
  }

  void _onHistoryChanged() {
    saveHistory.execute(widget.chatId, provider.history.toList());
  }

  @override
  void dispose() {
    provider.removeListener(_onHistoryChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('AI Chat')),
      body: LlmChatView(
        provider: provider,
        welcomeMessage: 'How can I help you?',
        style: LlmChatViewStyle(
          progressIndicatorColor: AppColors.kPrimaryColor,
          llmMessageStyle: LlmMessageStyle(
            decoration: BoxDecoration(
              color: AppColors.kSecondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          userMessageStyle: UserMessageStyle(
            textStyle: Styles.titleText16.copyWith(color: Colors.white),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
