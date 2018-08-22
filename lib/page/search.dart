import 'package:flutter/material.dart';
import 'package:flutter_npm_search/page/detail.dart';
import 'package:flutter_npm_search/request/request.dart';

Request request = new Request();

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    request.getSuggestions('react', 20).then((suggestions) {
      suggestions.forEach((sug) {
        print('${sug.searchScore.toString()} \n');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(),
          style: TextStyle(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            iconSize: 24.0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage('react'),
                  ));
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(child: Text('000')),
          Container(child: Text('001')),
          Container(child: Text('002')),
          Container(child: Text('004')),
        ],
      ),
    );
  }
}
