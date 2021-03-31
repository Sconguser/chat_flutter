import 'package:flutter/material.dart';
import 'package:chat/views/sign_in.dart';
import 'package:chat/views/sign_up.dart';
import 'package:chat/views/authenticate.dart';
import 'package:web_socket_channel/io.dart';
import 'views/chat.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authenticate(
      ),
      routes:{
        '/sign_in':(_)=> SignIn(),
        '/chat':(_)=>Chat(channel:IOWebSocketChannel.connect('wss://echo.websocket.org')),
      }
    );
  }
}