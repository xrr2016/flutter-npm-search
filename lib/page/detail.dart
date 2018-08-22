import 'package:flutter/material.dart';
import 'package:flutter_npm_search/model/detail.dart';
import 'package:flutter_npm_search/request/request.dart';

Request request = new Request();

class DetailPage extends StatefulWidget {
  final String name;

  DetailPage(this.name);

  @override
  _DetailPageState createState() => _DetailPageState(name);
}

class _DetailPageState extends State<DetailPage> {
  final String name;

  _DetailPageState(this.name);

  String title = 'Detail';

  @override
  void initState() {
    super.initState();
    print('start: ---------------');

    request.getPackageDetail('$name').then((Detail detail) {
      print(detail.analyzedAt);
      setState(() {
        title = detail.analyzedAt;
      });
    });

    print('end: ---------------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Container(child: Text('detail')),
    );
  }
}
