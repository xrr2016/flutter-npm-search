import 'package:flutter/material.dart';
import 'package:flutter_npm_search/model/detail.dart';
import 'package:flutter_npm_search/request/request.dart';

Request request = new Request();

class DetailPage extends StatefulWidget {
  final String name;

  DetailPage([this.name = '']);

  @override
  _DetailPageState createState() => _DetailPageState(name);
}

class _DetailPageState extends State<DetailPage> {
  Detail _detail;
  String _name = '';
  bool _isLoading = true;

  _DetailPageState(this._name);

  @override
  void initState() {
    super.initState();
    request.getPackageDetail(_name).then((Detail detail) {
      setState(() {
        _detail = detail;
        _isLoading = false;
        print(_detail.collected['metadata']['version']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
      ),
      body: AnimatedCrossFade(
        firstChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('Score: ${_detail.score['final']}'),
              Text('Version: ${_detail.collected['metadata']['version']}'),
            ],
          ),
        ),
        secondChild: Center(
          child: CircularProgressIndicator(),
        ),
        duration: Duration(milliseconds: 300),
        crossFadeState: _isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
  }
}
