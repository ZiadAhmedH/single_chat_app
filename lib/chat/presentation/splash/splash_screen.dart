import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:caht/chat/controller/chat_cubit.dart';
import 'package:caht/chat/presentation/chat_screen/chat_screen.dart';
import 'package:caht/core/colors.dart';
import 'package:caht/core/websocket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: AppColors.blackColor,
      splash: Image.asset("assets/images/chat.png"),
      nextScreen: BlocProvider(
        create: (context) => ChatCubit(WebSocketService()),
        child: ChatScreen(),
      ),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
      pageTransitionType: PageTransitionType.rightToLeft,
    );
  }
}
