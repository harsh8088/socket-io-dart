import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/web_socket_channel.dart';

import 'model/chat_message.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({super.key});

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  final List<ChatMessage> _messages = List.empty(growable: true);
  late WebSocketChannel channel;
  final TextEditingController _textController = TextEditingController();
  List<String> messages = [];

  late IO.Socket socket;
  int count = 0;

  @override
  void initState() {
    super.initState();
    socketIOConnection();
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
    var msg = {'body': message};
    channel.sink.add(json.encode(msg));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Welcome Feeds'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$count"),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void socketConnection() async {
    final wsUrl = Uri.parse('ws://10.10.50.76:8010');
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
      // _newMessage(message);
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
    });
  }

  void socketIOConnection() async {
    try {
      // socket = IO.io('http://10.10.50.76:8010');
      // socket.open();
      // socket.on('count', (data) {
      //   setState(() {
      //     count = int.parse(data);
      //   });
      // });
      print("socketIOConnection");


      socket = IO.io('http://10.10.50.76:8010');
      socket.onConnect((_) {
        print('connect');
        // socket.emit('msg', 'test');
      });
      socket.on('count', (data) => print(data));
      // socket.onDisconnect((_) => print('disconnect'));
      // socket.on('fromServer', (_) => print(_));



    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
