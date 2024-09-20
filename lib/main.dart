import 'package:flutter/material.dart';
import 'package:socket_samples/feeds_page.dart';

import 'chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Socket Samples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Socket Samples'),
        '/chat-room': (context) => ChatPage(
              username: ModalRoute.of(context)?.settings.arguments as String,
            ),
        '/feeds': (context) => const FeedsPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ExpansionTile(
                title: const Text('Chat'),
                subtitle: const Text('Group Chat Sample'),
                children: <Widget>[
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: TextField(
                              controller: _textController,
                              decoration: const InputDecoration(
                                hintText: 'Your Name or nickname',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              if (_textController.text.isNotEmpty) {
                                Navigator.pushNamed(
                                  context,
                                  '/chat-room',
                                  arguments: _textController.text,
                                );
                              }
                            },
                            child: const Text(
                              "Join",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ExpansionTile(
                title: const Text('Feeds'),
                subtitle: const Text('Feeds Sample'),
                children: <Widget>[
                  ListTile(
                    title: const Text('Socket Feeds'),
                    onTap: () {
                      Navigator.pushNamed(context, '/feeds');
                    },
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
