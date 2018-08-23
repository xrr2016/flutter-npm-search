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

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin {
  Detail _detail;
  String _name = '';
  bool _isLoading = true;
  List<Tab> _tabs = <Tab>[
    Tab(text: 'Readme'),
    Tab(text: 'aaa'),
    Tab(text: 'Readme'),
    Tab(text: 'Readme'),
  ];
  TabController _tabController;

  _DetailPageState(this._name);

  @override
  void initState() {
    _tabController = new TabController(length: _tabs.length, vsync: this);
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: AnimatedCrossFade(
        firstChild: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Center(
              child: Text('0'),
            ),
            Center(child: Text('1')),
            Center(child: Text('2')),
            Center(child: Text('3')),
          ],
        ),
        secondChild: Center(child: CircularProgressIndicator()),
        duration: Duration(milliseconds: 300),
        crossFadeState: _isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
  }
}
