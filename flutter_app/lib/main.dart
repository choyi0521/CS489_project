import 'model/post.dart';
import 'chat_page.dart';
import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'nav_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}
//void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //Firestore firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Ethical Issues',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
      home: new ListPage(title: 'Ethical Issues'),
      // home: DetailPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _selectedIndex = 1;
  List posts;
  List favPosts;
  List chatPosts;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    posts = getPosts();
    updateFavPosts();
    updateChatPosts();

    super.initState();
  }

  void updateFavPosts(){
    favPosts=<Post>[];
    for (var i=0; i<posts.length; i++){
      if (posts[i].isFavorite) favPosts.add(posts[i]);
    }
  }
  void updateChatPosts(){
    chatPosts=<Post>[];
    for (var i=0; i<posts.length; i++){
      if (posts[i].onChannel) chatPosts.add(posts[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    updateFavPosts();
    updateChatPosts();
    ListTile makeListTile(Post post) => _selectedIndex<2?_selectedIndex==0?
    ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      leading: Container(
        child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(post.messages.last.user.avatar)
                )
            )
        ),
      ),
      title: Text(
        post.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Text(post.messages.last.text, style: TextStyle(color: Colors.white70))),
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(post: post)));
      },
    ):
    ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      title: Text(
        post.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Text(post.category, style: TextStyle(color: Colors.yellow))),
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(post: post)));
      },
    ):
    ListTile(
      contentPadding:
          EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 2.0),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1.0, color: Colors.white24))),
        child: IconButton(
          icon:post.isFavorite ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.white),
          onPressed: (){
            setState(() {
              post.isFavorite = !post.isFavorite;
            });
          },
        ),
      ),
      title: Text(
        post.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(post.category, style: TextStyle(color: Colors.yellow))),
        ],
      ),
      trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(post: post)));
      },
    );

    Card makeCard(Post post) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(post),
          ),
        );

    final tab1 = chatPosts.length == 0 ?
    Center(
        child:Text('Empty', style: TextStyle(color: Colors.white24, fontSize: 30))
    ): Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: chatPosts.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(chatPosts[index]);
        },
      ),
    );

    final tab2 = posts.length == 0 ?
    Center(
        child:Text('Empty', style: TextStyle(color: Colors.white24, fontSize: 30))
    ):
    Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(posts[index]);
        },
      ),
    );

    final tab3 = favPosts.length == 0 ?
    Center(
        child:Text('Empty', style: TextStyle(color: Colors.white24, fontSize: 30))
    ):
    Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: favPosts.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(favPosts[index]);
        },
      ),
    );

    final List<Widget> _widgetOptions = <Widget>[
      tab1,
      tab2,
      tab3,
    ];

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(widget.title)
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      drawer: NavDrawer(),
      body:  Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Discussion'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
