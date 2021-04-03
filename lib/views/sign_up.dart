import 'package:flutter/material.dart';
import 'package:chat/shared/constants.dart';
import 'package:chat/shared/constants.dart';
import 'package:chat/shared/loading.dart';
import 'package:chat/views/chat.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/album.dart';
import 'dart:convert';
import 'package:chat/models/user_from_registration.dart';


Future<UserFromRegistration> createUser(String username, String password, String email) async{
  try{
    final response = await http.post(
    Uri.https('rathahon.pythonanywhere.com', 'api/user-create/'),
    headers:<String, String>{
      'Content-Type':'application/json; charset=UTF-8',
      'Authorization': 'Token fa438743b59061bc1a158e3f5de687980ac4f7fa',
      'Accept':'application/json; charset=UTF-8',
    },
    body:jsonEncode(<String, String>{
      'username':username,
       'email':email,
      'password':password
    }),
  );
  print(response.statusCode);
  print(jsonDecode(response.body));
  if(response.statusCode==201){
    print('Udalo sie stworzyc uzytkownika');
    return UserFromRegistration.fromJson(jsonDecode(response.body));
  }else{
    print("Nie udalo sie stworzyc uzytkownika");
    throw Exception('Failed to create user');
  }}
  catch(e){print(e);}
}




class SignUp extends StatefulWidget {


  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  Future<UserFromRegistration> _futureUser;

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String username ='';
  bool loading = false;
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
              child: _futureUser==null? Column(
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
                  TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Username'),
                      obscureText: false,
                      validator:(value)=>value.isEmpty ? 'Enter username' : null,
                      onChanged:(value){
                        setState((){
                          username = value;
                        });
                      }
                  ),
                  SizedBox(height:20),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _futureUser = createUser(username, password,email);
                      });
                      print("email= $email");
                      print("password = $password");
                      print("username= $username");
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      onPrimary: Colors.deepPurple,
                    ),
                    child: Text('Sign up'),

                  )

                ],
              ):
                FutureBuilder<UserFromRegistration>(
                  future: _futureUser,
                  builder:(context, snapshot){
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
