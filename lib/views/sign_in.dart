import 'package:flutter/material.dart';
import 'package:chat/shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final _formKey = GlobalKey<FormState>();
  String email='';
  String password='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.greenAccent,
            ),
            label:Text('Register'),
            onPressed: (){
              widget.toggleView();
            },
          ),


        ],
        title: Text('Pelna Dyskrecja'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
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
                  child: Text('Sign In'),
              )
            ],
          ),
        )
      )
    );
  }
}
