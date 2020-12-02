import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';
import 'model/post.dart';

class ChatPage extends StatefulWidget {
  final ChatUser user = ChatUser(
    name: "duck",
    uid: "duck",
    avatar: "https://thewiki.ewr1.vultrobjects.com/data/313131343036363933362d6d2e6a7067.jpg"
  );

  ChatPage({Key key, this.post}) : super(key: key);

  final Post post;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  void onSend(ChatMessage message) {
    setState(() {
      widget.post.messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      title: Text(widget.post.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => setState((){
            widget.post.onChannel=false;
            Navigator.pop(context);
          })
        ),
      ],
    );

    return Scaffold(
      appBar: topAppBar,
      body:DashChat(
        user: widget.user,
        messages: widget.post.messages,
        onSend: onSend,
        inputContainerStyle: BoxDecoration(
          border: Border.all(width: 0.0),
          color: Colors.white
        ),
      )
    );
  }
}
