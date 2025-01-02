import 'package:caht/chat/entities/message.dart';
import 'package:caht/chat/presentation/chat_screen/components/custom_text.dart';
import 'package:caht/core/colors.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Align(
        alignment: message.isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: message.isSender ? Colors.blueGrey[700] : Colors.grey[800],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: message.isSender ? Radius.circular(20) : Radius.zero,
              bottomRight: message.isSender ? Radius.zero : Radius.circular(20),
            ),
          ),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
                 mainAxisSize: MainAxisSize.min,
                  children: [
                   CustomText(text: message.name.toString(), color:AppColors.blueColor), // Replace with a real sender name
                  ],
                ),
              ),
              Column(
                crossAxisAlignment:
                    message.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "Avenir",
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    message.timeNow, // Replace with a real timestamp
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
