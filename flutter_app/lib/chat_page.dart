import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';
import 'model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      set_array(message.text);
    });
  }
  void set_array(String message) async {
    var rs = [];
    await FirebaseFirestore.instance.collection("posts").doc("post"+widget.post.postnum.toString()).get().then((DocumentSnapshot documentSnapshot){
      rs =  documentSnapshot["chat"];
    });
    rs.add(message);
    await FirebaseFirestore.instance.collection("posts").doc("post"+widget.post.postnum.toString()).update({"chat":rs});
    await FirebaseFirestore.instance.collection("posts").doc("post"+widget.post.postnum.toString()).get().then((DocumentSnapshot documentSnapshot){
      rs = documentSnapshot["user"];
    });
    rs.add(widget.user.name);
    await FirebaseFirestore.instance.collection("posts").doc("post"+widget.post.postnum.toString()).update({"user":rs});
    await FirebaseFirestore.instance.collection("posts").doc("post"+widget.post.postnum.toString()).get().then((DocumentSnapshot documentSnapshot){
      rs = documentSnapshot["icon"];
    });
    rs.add(widget.user.avatar);
    await FirebaseFirestore.instance.collection("posts").doc("post"+widget.post.postnum.toString()).update({"icon":rs});
    await FirebaseFirestore.instance.collection("posts").doc("post"+widget.post.postnum.toString()).get().then((DocumentSnapshot documentSnapshot){
      rs = documentSnapshot["timeline"];
    });
    rs.add(DateTime.now());
    await FirebaseFirestore.instance.collection("posts").doc("post"+widget.post.postnum.toString()).update({"timeline":rs});
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
