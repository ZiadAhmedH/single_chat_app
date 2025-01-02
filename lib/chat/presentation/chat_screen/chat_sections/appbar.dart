import 'package:caht/chat/presentation/chat_screen/components/custom_text.dart';
import 'package:caht/core/colors.dart';
import 'package:flutter/material.dart';

class AppbarChat extends StatelessWidget implements PreferredSizeWidget {
  const AppbarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blackColor,
      title: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/images/colouring.jpg'),
          ),
          const SizedBox(width: 10),
          CustomText(
            text: "Chaffined Decoders 🐊",
            color: AppColors.whiteColor,
          ),
        ],
      ),
      elevation: 1,
    );

    
  }
  

 @override

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  }
