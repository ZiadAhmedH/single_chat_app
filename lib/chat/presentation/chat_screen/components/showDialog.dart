import 'package:caht/chat/controller/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class alertEnterName extends StatelessWidget {
  const alertEnterName(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = context.read<ChatCubit>().clientName;
    return AlertDialog(
      title: const Text('Enter Your Name'),
      content: TextField(
        controller: nameController ,
        decoration: const InputDecoration(
          hintText: 'Name..',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (nameController.text.trim().isNotEmpty) {
              Navigator.of(context).pop(nameController.text.trim()); // Close the dialog and return the name
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}