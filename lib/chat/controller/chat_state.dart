import 'package:equatable/equatable.dart';
import 'package:caht/chat/entities/message.dart';

class ChatState extends Equatable {
  final List<Message> messages;
  final String clientId;


  const ChatState({
    required this.messages,
    required this.clientId,
  });

  ChatState copyWith({
    List<Message>? messages,
    String? clientId,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      clientId: clientId ?? this.clientId,
    );
  }

  ChatState addMessage(Message message) {
    return copyWith(
      messages: [...messages, message],
    );
  }


  factory ChatState.initial(String clientId) {
    return ChatState(
      messages: [],
      clientId: clientId,
    );
  }

  @override
  List<Object> get props => [messages, clientId];
}

  class MassageAddedNotifiy extends ChatState {
  const MassageAddedNotifiy({required super.messages, required super.clientId});
}

