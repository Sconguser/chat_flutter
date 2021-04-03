import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chat/shared/constants.dart';
import 'package:chat/shared/loading.dart';
import 'package:chat/views/chat.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/album.dart';

Future<Album> createAlbum(String username, String password) async{
  try{final response = await http.post(
    Uri.https('rathahon.pythonanywhere.com', 'api/user-login/'),
    headers:<String, String>{
      /// 'Content-Type':'application/json; charset=UTF-8',
      'Authorization': 'Token fa438743b59061bc1a158e3f5de687980ac4f7fa',
    },
    body:jsonEncode(<String, String>{
      'username':username,
      'password':password
      }),
  );
  print(response.statusCode);
  if(response.statusCode==200){
    print('Udalo sie zalogowac uzytkownika');
    return Album.fromJson(jsonDecode(response.body));
  }else{
    print("Nie udalo sie zalogowac uzytkownika");
    throw Exception('Failed to create album');
  }}
  catch(e){print(e);}
}

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  Future<Album> _futureAlbum;
  final _formKey = GlobalKey<FormState>();
  String email='';
  String password='';
  bool loading = false;
  //bool isSigned = false;
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
          child: (_futureAlbum==null)? Column(
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
                obscureText: false,
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
                  ///Navigator.pushReplacementNamed(context, '/chat');
                  //setState(() => isSigned=true);
                  print(email);
                  print(password);
                  setState((){
                    _futureAlbum = createAlbum(email,password);
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.deepPurple,
                ),
                  child: Text('Sign In'),
              )
            ],
          ) :
              FutureBuilder<Album>(
                future:_futureAlbum,
                builder:(context,snapshot){
                  if(snapshot.hasData){
                    return Text(snapshot.data.username);
                  }
                  else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return Loading();
                }
              )

        )
      )
    );
  }
}
