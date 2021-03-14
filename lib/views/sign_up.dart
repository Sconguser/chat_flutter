import 'package:flutter/material.dart';
import 'package:chat/shared/constants.dart';

class SignUp extends StatefulWidget {


  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[600],
        appBar: AppBar(
          title: Text('Pelna Dyskrecja'),
          backgroundColor: Colors.brown[800],
          centerTitle: true,
          actions: [
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.greenAccent,
              ),
              label:Text('Login'),
              onPressed: (){
                widget.toggleView();
              },
            ),
          ],
        ),
        body:Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height:20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (value)=>value.isEmpty ? 'Enter email' : null,
                    onChanged: (value){
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox(height:20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (value)=>value.isEmpty ? 'Enter password' : null,
                    onChanged: (value){
                      setState(() {
                        password=value;
                      });
                    },
                  ),
                  SizedBox(height:20),
                  ElevatedButton(
                    onPressed: (){
                      print(email);
                      print(password);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      onPrimary: Colors.deepPurple,
                    ),
                    child: Text('Sign up'),

                  )

                ],
              ),
            )
        )
    );
  }
}
