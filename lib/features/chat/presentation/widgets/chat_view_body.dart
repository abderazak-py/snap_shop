import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key, required this.model});

  final GenerativeModel model;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.07),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            'Ai Chat',
            style: Styles.titleText26.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        Expanded(
          child: LlmChatView(
            provider: FirebaseProvider(model: model),
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
        ),
      ],
    );
  }
}
