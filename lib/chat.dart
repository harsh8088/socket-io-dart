import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_samples/widgets/chat_input.dart';
import 'package:socket_samples/widgets/chat_list.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'model/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.username});

  final String username;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = List.empty(growable: true);
  late WebSocketChannel channel;
  final TextEditingController _textController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    socketConnection();
  }

  void _newMessage(String message) {
    try {
      var chatMessage = ChatMessage.fromJson(jsonDecode(message));
      setState(() {
        _messages.add(chatMessage);
      });
    } catch (_) {
      print(_.toString());
    }
  }

  void _sendMessage(String message) {
    var msg = {'sender': widget.username, 'body': message};
    channel.sink.add(json.encode(msg));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Welcome ${widget.username}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child:
                    ChatList(messages: _messages, userName: widget.username)),
            ChatInput(
              textController: _textController,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void socketConnection() async {
    final wsUrl = Uri.parse('ws://10.10.50.76:8080');
    channel = WebSocketChannel.connect(wsUrl);

    try {
      await channel.ready;
    } on SocketException catch (e) {
      // Handle the exception.
      print("SocketException:${e.toString()}");
    } on WebSocketChannelException catch (e) {
      // Handle the exception.
      print("WebSocketChannelException:${e.toString()}");
    }
    channel.stream.listen((message) {
      print("Message:$message");
      _newMessage(message);
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
    });
  }
}
