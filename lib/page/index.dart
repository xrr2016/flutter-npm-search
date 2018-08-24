import 'package:flutter/material.dart';
import 'package:flutter_npm_search/page/detail.dart';
import 'package:flutter_npm_search/page/search.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool _isNightMode = false;
  List _hots = ['flutter', 'react', 'vue', 'lodash', 'axios', 'angular', 'express'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(color: Theme.of(context).highlightColor),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(Icons.search),
                ),
                Text('搜索', style: TextStyle(fontSize: 18.0)),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert, size: 26.0),
            onSelected: (choice) {
              print(choice);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: SwitchListTile(
                    title: Text('夜间模式'),
                    value: _isNightMode,
                    onChanged: (val) {
                      setState(() {
                        _isNightMode = val;
                      });
                    },
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _hots.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage(_hots[index])),
              );
            },
            child: ListTile(
              title: Text(_hots[index]),
            ),
          );
        },
      ),
    );
  }
}
