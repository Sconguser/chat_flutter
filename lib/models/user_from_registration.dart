import 'package:http/http.dart';

class UserFromRegistration{
  final String username;
  final String password;
  final String email;
  UserFromRegistration({this.username, this.password, this.email});

  factory UserFromRegistration.fromJson(Map<String, dynamic> json){
    return UserFromRegistration(
        username:json['username'],
        password: json['password'],
        email:json['email']
    );
  }
}