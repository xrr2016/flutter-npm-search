import 'package:flutter/material.dart';

import 'package:flutter_npm_search/page/detail.dart';
import 'package:flutter_npm_search/page/search.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool _isNightMode = false;

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
      body: ListView(
        padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0, bottom: 24.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: Text('热门搜索:', style: TextStyle(fontSize: 16.0)),
          ),
          PackageItem('lodash'),
          PackageItem('request'),
          PackageItem('chalk'),
          PackageItem('react'),
          PackageItem('express'),
          PackageItem('async'),
          PackageItem('commander'),
          PackageItem('moment'),
          PackageItem('bluebird'),
          PackageItem('debug'),
          PackageItem('prop-types'),
          PackageItem('react-dom'),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: Text('历史搜索:', style: TextStyle(fontSize: 16.0)),
          ),
          PackageItem('react'),
          PackageItem('vue'),
          PackageItem('d3'),
          PackageItem('axios'),
        ],
      ),
    );
  }
}

class PackageItem extends StatelessWidget {
  final String name;

  PackageItem(this.name);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(name)),
        );
      },
    );
  }
}
