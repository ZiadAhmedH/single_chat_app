import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caht/core/websocket.dart';
import 'package:caht/feature/controller/chat_cubit.dart';
import 'package:caht/feature/presentation/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final webSocketService = WebSocketService();
  
  runApp(MyApp(webSocketService: webSocketService));
}

class MyApp extends StatelessWidget {
  final WebSocketService webSocketService;

  MyApp({required this.webSocketService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(webSocketService),
      child: MaterialApp(
        home: ChatScreen(),
      ),
    );
  }
}
