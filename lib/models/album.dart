import 'package:http/http.dart';

class Album{
 final String token;

 Album({this.token});

 factory Album.fromJson(Map<String, dynamic> json){
   return Album(
     token:json['token']
   );
 }
}