import 'package:flutter/material.dart';

import 'model/user_chat.dart';
// import 'model/user_chat';

class UserMessageCard extends StatelessWidget {
  const UserMessageCard({super.key, required this.userChat});
  final UserChat userChat;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.person_3_rounded),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(userChat.message,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14)),
            ),
          ],
        ));
  }
}
