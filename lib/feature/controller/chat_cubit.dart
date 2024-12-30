import 'dart:convert';
import 'package:caht/core/clientManger.dart';
import 'package:caht/core/websocket.dart';
import 'package:caht/feature/controller/chat_state.dart';
import 'package:caht/feature/entities/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class ChatCubit extends Cubit<ChatState> {
  final WebSocketService _webSocketService;
  late String clientId;

  ChatCubit(this._webSocketService) : super(ChatState.initial('')) {
    _initializeClientId();

    _webSocketService.stream.listen((data) {
      print("WebSocket stream data: $data");  

      String decodedMessage;
      
      if (data is List<int>) {
        decodedMessage = utf8.decode(data); 
        print('Received byte data, decoded: $decodedMessage');
      } 
      else if (data is String) {
        decodedMessage = data; 
        print('Received string data: $decodedMessage');
      } else {
        print('Unknown data type received: $data');
        return; 
      }

      try {
        final messageData = jsonDecode(decodedMessage); 
        print("Decoded message: $messageData");

        // Create a new Message object
        final newMessage = Message(
          content: messageData['message'],
          isSender: messageData['clientId'] == clientId, 
          senderId: messageData['clientId'],
          timesNow: messageData['timeNow'],
        );

        emit(state.addMessage(newMessage));
      } catch (e) {
        print('Error parsing message: $e');
      }
    });
  }

  void sendMessage(String message) {
    final messageData = {
      'clientId': clientId,
      'message': message,
      'timeNow': DateTime.now().toIso8601String(),
    };
    print('Sending message: $messageData');
    _webSocketService.sendMessage(jsonEncode(messageData)); 

    final newMessage = Message(content: message, isSender: true, senderId:clientId, timesNow: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    emit(state.addMessage(newMessage));
  }

  Future<void> _initializeClientId() async {
    clientId = await ClientIdManager.getClientId();
    print('Client ID initialized: $clientId');
    emit(ChatState.initial(clientId)); 
  }

  @override
  Future<void> close() {
    _webSocketService.dispose(state); 
    return super.close();
  }
}

