import 'model/post.dart';
import 'chat_page.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.post}) : super(key: key);

  final Post post;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int page = 0;
  List<Map<String, double>> dataMaps = [];
  final List<String> answers = [
    "strongly agree",
    "agree",
    "neutral",
    "disagree",
    "strongly disagree"
  ];

  @override
  void initState() {
    for(int i=0; i<widget.post.surveys.length; i++) {
      List<double> rs = [];
      double s = 0.0;
      for(int j=0; j<5; j++) {
        rs.add(Random().nextInt(300) + 50.0);
        s += rs[j];
      }
      dataMaps.add({
        "strongly agree": rs[0],
        "agree": rs[1],
        "neutral": rs[2],
        "disagree": rs[3],
        "strongly disagree": rs[4],
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 80.0),
        Text(
          widget.post.title,
          style: TextStyle(color: Colors.white, fontSize: 40.0),
        )
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.post.imagePath ?? 'assets/default_post_image.jpg'),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .6)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 15.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        Positioned(
          right: 15.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              setState(() {
                widget.post.isFavorite = !widget.post.isFavorite;
              });
            },
            child: widget.post.isFavorite ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      widget.post.content,
      style: TextStyle(fontSize: 18.0),
    );
    final survey = Container(
      //padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
      width: MediaQuery.of(context).size.width,
      /*decoration: BoxDecoration(
          border: Border(
              top: BorderSide(width: 1.0, color: Colors.black26)
          )
      ),*/
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.post.surveys.length,
        itemBuilder: (BuildContext context, int index) {
          return
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Q${index+1}. ${widget.post.surveys[index].question}', style: TextStyle(color: Colors.black, fontSize: 18.0))
                ),
                Slider(
                  min: 0.0,
                  max: 4.0,
                  divisions: 4,
                  value: widget.post.surveys[index].value,
                  activeColor: Color(0xff512ea8),
                  inactiveColor: Color(0xffac9bcc),
                  onChanged: (newValue) {
                    setState(() {
                      widget.post.surveys[index].value = newValue;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      child: Text('strongly agree', style: TextStyle(color: Colors.black54, fontSize: 10.0), textAlign: TextAlign.center),
                    ),
                    Container(
                      width: 50,
                      child: Text('agree', style: TextStyle(color: Colors.black54, fontSize: 10.0), textAlign: TextAlign.center),
                    ),
                    Container(
                      width: 50,
                      child: Text('neutral', style: TextStyle(color: Colors.black54, fontSize: 10.0), textAlign: TextAlign.center),
                    ),
                    Container(
                      width: 50,
                      child: Text('disagree', style: TextStyle(color: Colors.black54, fontSize: 10.0), textAlign: TextAlign.center),
                    ),
                    Container(
                      width: 50,
                      child: Text('strongly disagree', style: TextStyle(color: Colors.black54, fontSize: 10.0), textAlign: TextAlign.center),
                    )
                  ]
                ),
                SizedBox(height: 20.0)
              ],
            );
        },
      ),
    );

    final statButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => setState(() {page = 1;}),
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
              Text("Analyze the responses", style: TextStyle(color: Colors.white)),
        ));

    final charts = Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.post.surveys.length,
        itemBuilder: (BuildContext context, int index) {
          return
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 5.0),
                    alignment: Alignment.centerLeft,
                    child: Text('Q${index+1}. ${widget.post.surveys[index].question}', style: TextStyle(color: Colors.black, fontSize: 18.0))
                ),
                Container(
                    padding: EdgeInsets.only(left: 5.0),
                    alignment: Alignment.centerLeft,
                    child: Text('A${index+1}. ${answers[widget.post.surveys[index].value.toInt()]}', style: TextStyle(color: Colors.blueGrey, fontSize: 18.0))
                ),
                SizedBox(height: 10.0),
                PieChart(
                  dataMap: dataMaps[index],
                  centerText: "Global",
                  colorList: [Colors.indigoAccent,Colors.lightBlueAccent,Colors.lightGreenAccent,Colors.orangeAccent,Colors.red],
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: false
                  ),
                ),
                SizedBox(height: 25.0)
              ],
            );
        },
      ),
    );
    final chatButton = Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => setState(() {
            widget.post.onChannel = true;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(post: widget.post)));
          }),
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
          Text("Discuss", style: TextStyle(color: Colors.white)),
        ));

    final backButton = Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => setState(() {page = 0;}),
          color: Colors.grey,
          child:
          Text("Back", style: TextStyle(color: Colors.white)),
        ));

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children:
          page == 0 ?
          <Widget>[
            bottomContentText,
            SizedBox(height: 10.0),
            survey,
            SizedBox(height: 10.0),
            statButton
          ]:
          <Widget>[
            charts,
            SizedBox(height: 15.0),
            backButton,
            chatButton
          ],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[topContent, bottomContent],
        ),
      )
    );
  }
}
