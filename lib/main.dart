import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_npm_search/page/detail.dart';
import 'package:flutter_npm_search/page/search.dart';

void main() {
  runApp(new NpmSearchApp());
}

class NpmSearchApp extends StatefulWidget {
  @override
  _NpmSearchAppState createState() => _NpmSearchAppState();
}

class _NpmSearchAppState extends State<NpmSearchApp> {
  String name;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Npm search",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SearchPage(),
        '/detail': (context) => DetailPage(name),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
