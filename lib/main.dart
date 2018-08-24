import 'package:flutter/material.dart';

import 'package:flutter_npm_search/page/detail.dart';
import 'package:flutter_npm_search/page/index.dart';
import 'package:flutter_npm_search/page/search.dart';
import 'package:flutter_npm_search/page/web_view.dart';

void main() {
  runApp(new NpmSearchApp());
}

class NpmSearchApp extends StatefulWidget {
  @override
  _NpmSearchAppState createState() => _NpmSearchAppState();
}

class _NpmSearchAppState extends State<NpmSearchApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Npm search",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => IndexPage(),
        '/search': (context) => SearchPage(),
        '/detail': (context) => DetailPage(),
        '/webview': (context) => WebViewPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
