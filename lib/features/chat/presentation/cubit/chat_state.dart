part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<ChatMessage> history;
  const ChatSuccess(this.history);
}

class ChatFailure extends ChatState {
  final String message;
  const ChatFailure(this.message);
}
