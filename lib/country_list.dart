import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'country_details.dart';


class HomeApp extends StatefulWidget {

  @override
  HomeAppState createState() {
    return new HomeAppState();
  }
}

class HomeAppState extends State<HomeApp> {
  var countries;
  Color mainColor = const Color(0xff3C3261);

  void getData() async {
    var data = await getJson();

    setState(() {
      countries = data ['results'];
    });
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: new Icon(
          Icons.arrow_back,
          color: mainColor,
        ),
        title: new Text(
          'Countries',
          style: new TextStyle(color: mainColor, fontFamily: 'Arvo', fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          new Icon(
            Icons.menu,
            color: mainColor,
          ),
        ],
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new CountryTitle(mainColor),
            new Expanded(
              child: new ListView.builder(
                itemCount: countries == null ? 0 : countries.length,
                itemBuilder: (context, i) {
                  return new FlatButton(
                    child: new CountryCell(countries, i),
                    padding: const EdgeInsets.all(0.0),
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context){
                        return new CountryDetails(countries[i]);
                      }));
                    },
                    color: Colors.white,
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class CountryCell extends StatefulWidget {

  final countries, i;

  CountryCell(this.countries, this.i);

  @override
  _CountryCellState createState() => _CountryCellState();
}

class _CountryCellState extends State<CountryCell> {
  Color mainColor = const Color(0xff3C3261);

  var imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Container(
                margin: const EdgeInsets.all(16.0),
                child: new Container(
                  width: 70.0,
                  height: 70.0,
                ),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: new DecorationImage(
                    image: new NetworkImage(
                      imageUrl + widget.countries[widget.i]['poster_path']
                    ),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    new BoxShadow(
                      color: mainColor,
                      blurRadius: 5.0,
                      offset: new Offset(2.0, 5.0)
                    ),
                  ],
                ),
              ),
            ),
            new Expanded(
              child: new Container(
                margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: new Column(
                  children: [
                    new Text(
                      widget.countries[widget.i]['title'],
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(2.0)
                    ),
                    new Text(
                      widget.countries[widget.i]['overview'],
                      maxLines: 3,
                      style: new TextStyle(
                        color: const Color(0xff8785A4),
                        fontFamily: 'Arvo'
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            )
          ],
        ),
        new Container(
          width: 300.0,
          height: 0.5,
          color: const Color(0xD2D2E1ff),
          margin: const EdgeInsets.all(16.0),
        )
      ],
    );
  }
}

class CountryTitle extends StatelessWidget {
  final Color mainColor;

  CountryTitle(this.mainColor);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: new Text(
        'Top Listed',
        style: new TextStyle(
          fontSize:  30.0,
          color: mainColor,
          fontWeight:  FontWeight.bold,
          fontFamily: 'Arvo', 
          ),
          textAlign: TextAlign.left,
      ),
    );
  }
}

Future<Map> getJson() async {
  var url = 'http://api.themoviedb.org/3/discover/movie?api_key=004cbaf19212094e32aa9ef6f6577f22';
  http.Response response = await http.get(url);
  if(response.statusCode == 200){
    return json.decode(response.body);
  }else{
    throw Exception('Failed to fetch data');
  }
}
