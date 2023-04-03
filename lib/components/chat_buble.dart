import 'package:chat_app_bloc/constant.dart';
import 'package:chat_app_bloc/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubles extends StatelessWidget {
  const ChatBubles({super.key, required this.messege});
  final Message messege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, bottom: 24, top: 24, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(24),
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          color: kPrimatrColor,
        ),
        child: Text(
          messege.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBublesForFriend extends StatelessWidget {
  const ChatBublesForFriend({super.key, required this.messege});
  final Message messege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, bottom: 24, top: 24, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          color: Color(0xff006D84),
        ),
        child: Text(
          messege.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
