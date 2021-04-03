import 'package:http/http.dart';

class Album{
 final String username;

 Album({this.username});

 factory Album.fromJson(Map<String, dynamic> json){
   return Album(
     username:json['username']
   );
 }
}