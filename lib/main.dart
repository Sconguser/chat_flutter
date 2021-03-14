import 'package:flutter/material.dart';
import 'package:chat/views/sign_in.dart';
import 'package:chat/views/sign_up.dart';
import 'package:chat/views/authenticate.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authenticate()
    );
  }
}
