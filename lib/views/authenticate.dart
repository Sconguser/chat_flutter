import 'package:flutter/material.dart';
import 'package:chat/views/sign_up.dart';
import 'package:chat/views/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showSignIn) return SignIn(toggleView:toggleView);
    else return SignUp(toggleView:toggleView);

  }
}
