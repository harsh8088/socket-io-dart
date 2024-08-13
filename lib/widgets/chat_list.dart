import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/chat_message.dart';

class ChatList extends StatelessWidget {
  final List<ChatMessage> messages;
  final String userName;

  const ChatList({super.key, required this.messages, required this.userName});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      reverse: false, // Display latest messages at the bottom
      itemBuilder: (context, index) {
        final message = messages[index];
        final dateTime = DateTime.fromMillisecondsSinceEpoch(message.sentAt!);
        final formatter = DateFormat.jm(); // Format for AM/PM time
        final formattedDate = formatter.format(dateTime);

        return Align(
          alignment: userName == message.sender
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            constraints: const BoxConstraints(minWidth: 80, maxWidth: 160),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding:
                const EdgeInsets.only(left: 10, right: 8, top: 4, bottom: 1),
            decoration: BoxDecoration(
              color: userName == message.sender
                  ? Colors.green.shade100
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userName != message.sender
                    ? Text(
                        message.sender.toString(),
                        style: const TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  message.body.toString(),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            fontSize: 9,
                            color: Colors.black38,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
