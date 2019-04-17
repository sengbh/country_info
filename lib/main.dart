import 'package:flutter/material.dart';

void main() => runApp(new MainApp());


class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Country List',
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeApp>{
  int _currentIndex = 0;
  final List<Widget> _children = [
    ColorTab(Colors.white),
    ColorTab(Colors.grey),
    ColorTab(Colors.brown),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: PageOne(),
        centerTitle: true,
        title: new Text("HOOME"),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle),
            title: new Text("STUFF"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text("Profile"),
          ),
        ]
      ),
    );
  }

  void OnTab(int index) {
    setState((){
      _currentIndex = index;
    });
  } 
}

class ColorTab extends StatelessWidget {
  final Color color;

  ColorTab(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

class PageOne extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("Home Screen")
      ),
      body: Center(
        child: RaisedButton(
          child: new Text("Open page"),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageTwo()) 
            );
          },
        ),
      ),
    );
  }

}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = "back";
    return Scaffold(
      appBar: AppBar(
        title: new Center(
          child: new Text("Details"),
        ),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text(data),
        ), 
      ),
    );
  }
}