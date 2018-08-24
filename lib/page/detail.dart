import 'package:flutter/material.dart';

import 'package:flutter_npm_search/page/web_view.dart';
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
    Tab(text: 'Info'),
    Tab(text: 'Stats'),
    Tab(text: 'Score'),
    Tab(text: 'Maintainers'),
  ];
  TabController _tabController;

  _DetailPageState(this._name);

  void _getDetail() {
    request.getPackageDetail(_name).then((Detail detail) {
      setState(() {
        _detail = detail;
        _isLoading = false;
      });
    }).catchError((err) {
      new SimpleDialog(
        title: Text('加载失败，请重试'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: _getDetail,
            child: Text('确定'),
          )
        ],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _getDetail();
    _tabController = new TabController(length: _tabs.length, vsync: this);
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
      body: _detail != null
          ? AnimatedCrossFade(
              firstChild: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  ReadmeView(_detail),
                  StatsView(_detail),
                  ScoreView(_detail),
                  MaintainersView(_detail),
                ],
              ),
              secondChild: Center(child: CircularProgressIndicator()),
              duration: Duration(milliseconds: 300),
              crossFadeState: _isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class ReadmeView extends StatelessWidget {
  final Detail _detail;

  ReadmeView(this._detail);

  @override
  Widget build(BuildContext context) {
    List keywords = _detail.collected['metadata']['keywords'] != null
        ? _detail.collected['metadata']['keywords']
        : [];
    List<Widget> _keywords = [];

    for (int i = 0; i < keywords.length; i++) {
      _keywords.add(
        Padding(
          padding: EdgeInsets.only(right: 8.0, bottom: 8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(color: Colors.grey),
            child: Text(
              keywords[i],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    Map links = _detail.collected['metadata']['links'];
    String _readme = _detail.collected['metadata']['readme'] != null
        ? _detail.collected['metadata']['readme']
        : '';

    List badges =
        _detail.collected['source']['badges'] != null ? _detail.collected['source']['badges'] : [];
    List _badges = badges.map((badge) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Image.network(
          badge['urls']['original'],
        ),
      );
    }).toList();

    return ListView(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0, bottom: 24.0),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Text('Readme', style: TextStyle(fontSize: 16.0)),
        ),
        Text(_readme),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Text('Badges', style: TextStyle(fontSize: 16.0)),
        ),
        Row(children: _badges),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Text('Keywords', style: TextStyle(fontSize: 16.0)),
        ),
        Row(children: _keywords),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Text('License', style: TextStyle(fontSize: 16.0)),
        ),
        Text('${_detail.collected['metadata']['license']}'),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Text('Links', style: TextStyle(fontSize: 16.0)),
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              links['npm'],
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebViewPage(links['npm'])),
            );
          },
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              links['homepage'],
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebViewPage(links['homepage'])),
            );
          },
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              links['repository'],
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebViewPage(links['repository'])),
            );
          },
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              links['bugs'],
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebViewPage(links['bugs'])),
            );
          },
        ),
      ],
    );
  }
}

class StatsView extends StatelessWidget {
  final Detail _detail;

  StatsView(this._detail);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0, bottom: 24.0),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Text('Metadata', style: TextStyle(fontSize: 16.0)),
        ),
        StatItem('version', _detail.collected['metadata']['version']),
        StatItem('analyzed at', _detail.analyzedAt),
        StatItem('publish at', _detail.collected['metadata']['date']),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Text('Npm', style: TextStyle(fontSize: 16.0)),
        ),
        StatItem('dependents count', _detail.collected['npm']['dependentsCount'].toString()),
        StatItem('stars count', _detail.collected['npm']['starsCount'].toString()),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Text('Github', style: TextStyle(fontSize: 16.0)),
        ),
        StatItem('stars count', _detail.collected['github']['starsCount'].toString()),
        StatItem('forks count', _detail.collected['github']['forksCount'].toString()),
        StatItem('subscribers count', _detail.collected['github']['subscribersCount'].toString()),
        StatItem('issues count', _detail.collected['github']['issues']['count'].toString()),
        StatItem(
            'issues open count', _detail.collected['github']['issues']['openCount'].toString()),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Text('Source', style: TextStyle(fontSize: 16.0)),
        ),
        StatItem('readme size', _detail.collected['source']['files']['readmeSize'].toString()),
        StatItem('tests size', _detail.collected['source']['files']['testsSize'].toString()),
        StatItem('has changelog', _detail.collected['source']['files']['hasChangelog'].toString()),
      ],
    );
  }
}

class StatItem extends StatelessWidget {
  final String label;
  final String value;

  StatItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$label:'),
          Text(value),
        ],
      ),
    );
  }
}

class ScoreView extends StatelessWidget {
  final Detail _detail;

  ScoreView(this._detail);

  String _num2Str(num number) {
    if (number == null) {
      return '';
    }
    return (number * 100).toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0, bottom: 24.0),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Text('Quality', style: TextStyle(fontSize: 16.0)),
            ),
            ScoreItem('carefulness', _num2Str(_detail.evaluation['quality']['carefulness'])),
            ScoreItem('tests', _num2Str(_detail.evaluation['quality']['tests'])),
            ScoreItem('health', _num2Str(_detail.evaluation['quality']['health'])),
            ScoreItem('branding', _num2Str(_detail.evaluation['quality']['branding'])),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Text('Popularity', style: TextStyle(fontSize: 16.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('communityInterest:'),
                  Text(_detail.evaluation['popularity']['communityInterest'].toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('downloadsCount:'),
                  Text(_detail.evaluation['popularity']['downloadsCount'].toInt().toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('downloadsAcceleration:'),
                  Text(
                      _detail.evaluation['popularity']['downloadsAcceleration'].toInt().toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('dependentsCount:'),
                  Text(_detail.evaluation['popularity']['dependentsCount'].toString()),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Text('Maintenance', style: TextStyle(fontSize: 16.0)),
            ),
            ScoreItem('releasesFrequency',
                _num2Str(_detail.evaluation['maintenance']['tereleasesFrequencyts'])),
            ScoreItem('commitsFrequency',
                _num2Str(_detail.evaluation['maintenance']['commitsFrequency'])),
            ScoreItem('openIssues', _num2Str(_detail.evaluation['maintenance']['openIssues'])),
            ScoreItem('issuesDistribution',
                _num2Str(_detail.evaluation['maintenance']['issuesDistribution'])),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Text('Score', style: TextStyle(fontSize: 16.0)),
            ),
            ScoreItem('final', _num2Str(_detail.score['final'])),
            ScoreItem('quality', _num2Str(_detail.score['detail']['quality'])),
            ScoreItem('popularity', _num2Str(_detail.score['detail']['popularity'])),
            ScoreItem('maintenance', _num2Str(_detail.score['detail']['maintenance'])),
          ].toList(),
        ),
      ],
    );
  }
}

class ScoreItem extends StatelessWidget {
  final String label;
  final String value;

  ScoreItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$label:'),
          Text(value),
        ],
      ),
    );
  }
}

class MaintainersView extends StatelessWidget {
  final Detail _detail;

  MaintainersView(this._detail);

  @override
  Widget build(BuildContext context) {
    List _maintainers = _detail.collected['metadata']['maintainers'];

    return ListView(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0, bottom: 24.0),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Text('Publisher', style: TextStyle(fontSize: 16.0)),
        ),
        MaintainerItem(
          _detail.collected['metadata']['publisher']['username'],
          _detail.collected['metadata']['publisher']['email'],
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: Text('Maintainers', style: TextStyle(fontSize: 16.0)),
        ),
        MaintainerItem(_maintainers[0]['username'], _maintainers[0]['email']),
      ],
    );
  }
}

//ListView.builder(
//itemBuilder: (context, index) {
//return MaintainerItem(
//_maintainers[index]['username'],
//_maintainers[index]['email'],
//);
//},
//itemCount: _maintainers.length,
//),

class MaintainerItem extends StatelessWidget {
  final String name;
  final String email;

  MaintainerItem(this.name, this.email);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(name), Text(email)],
      ),
    );
  }
}
