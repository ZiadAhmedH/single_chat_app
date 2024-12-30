import 'package:caht/feature/entities/message.dart';

class ChatState {
  final List<Message> messages; 
  final String clientId; 
  
  ChatState({
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
}

