import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:chat/views/sign_in.dart';


///channel:IOWebSocketChannel.connect('wss://echo.websocket.org')


class Chat extends StatefulWidget {


  final WebSocketChannel channel;
  Chat({Key key, @required this.channel}): super(key:key);


  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.greenAccent,
            ),
            label:Text('Log Out'),
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/sign_in');
            },
          ),
        ],
        title: Text('Pelna Dyskrecja'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText:'Wyslij wiadomosc'),
              ),
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context,snapshot){
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(snapshot.hasData ? '${snapshot.data}':''),
                );
            }
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send Message',
        child: Icon(Icons.send),
      ),
    );
  }
  void _sendMessage(){
    if(_controller.text.isNotEmpty){
      widget.channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose(){
    widget.channel.sink.close();
    super.dispose();
  }
}
