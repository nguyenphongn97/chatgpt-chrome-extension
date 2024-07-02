import 'package:flutter/material.dart';
import 'model/bot_chat.dart';

class BotMessageCard extends StatelessWidget {
  const BotMessageCard({super.key, required this.botChat});
  final BotChat botChat;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset("assets/google-gemini-icon.png")),
            const SizedBox(width: 10),
            Expanded(
              child: SelectableText(botChat.message,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14)),
            ),
          ],
        ));
  }
}
