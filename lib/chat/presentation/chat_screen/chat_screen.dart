import 'package:caht/chat/presentation/chat_screen/chat_sections/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:caht/chat/controller/chat_cubit.dart';
import 'package:caht/chat/controller/chat_state.dart';
import 'package:caht/chat/presentation/chat_screen/components/custom_text.dart';
import 'package:caht/chat/presentation/chat_screen/components/message_widget.dart';
import 'package:caht/core/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _messageController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showNameDialog());
  }

 void _showNameDialog() {
  showDialog(
  context: context,
  barrierDismissible: false,
  builder: (dialogContext) {
    final nameController = TextEditingController();
  return AlertDialog(
        title:  CustomText(text: "Enter your name..",color: AppColors.whiteColor,), 
        backgroundColor:AppColors.blackColor, 
        content: TextField(
          controller: nameController,
          style: const TextStyle(color: AppColors.whiteColor), // Input text color
          decoration: const InputDecoration(
            hintText: 'Name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                context.read<ChatCubit>().setClientName(nameController.text);
                Navigator.of(dialogContext).pop(); 
              }
            },
            child: CustomText(text: 'Submit', color: AppColors.blueColor)
          ),
        ],
      
    );
  },
);

}


  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      context.read<ChatCubit>().sendMessage(_messageController.text.trim());
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppbarChat(),
      body: Column(
        children: [
          _buildChatMessages(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return Expanded(
      child: BlocBuilder<ChatCubit, ChatState>(
  builder: (context, state) {
    if(state is MassageAddedNotifiy){
      _scrollToBottom();
    }

    if (state.messages.isEmpty) {
      return Center(
        child: Lottie.asset(
          "assets/lotties/empty_chat.json",
          height: 200,
        ),
      );
    }
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: state.messages.length,
      itemBuilder: (context, index) {
        final message = state.messages[index];
        return MessageWidget(message: message);
      },
    );
  },
)
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      color: AppColors.blackColor,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                style: TextStyle(color: AppColors.whiteColor),
                decoration: InputDecoration(
                  hintText: 'Message...',
                  hintStyle: TextStyle(color: AppColors.geryColor),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: AppColors.blueColor),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
