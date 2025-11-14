import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/core/widgets/error_widget.dart';
import 'package:snap_shop/features/chat/presentation/cubit/chat_cubit.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) => sl<ChatCubit>()..loadChat(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatInitial || state is ChatLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is ChatFailure) {
            return Scaffold(
              body: Center(child: CustomErrorWidget(errorMsg: state.message)),
            );
          }
          final cubit = context.read<ChatCubit>();
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.07),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Cart',
                    style: Styles.titleText26.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: LlmChatView(
                    provider: cubit.provider,
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
                        textStyle: Styles.titleText16.copyWith(
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onErrorCallback: (ctx, err) {
                      ScaffoldMessenger.of(
                        ctx,
                      ).showSnackBar(SnackBar(content: Text(err.message)));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
