import 'package:flutter/material.dart';

import 'package:flutter_npm_search/request/request.dart';
import 'package:flutter_npm_search/widget/card_result.dart';

Request request = new Request();

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _total = 0;
  int _pageIndex = 0;
  String _input = '';
  String _prevInput = '';
  List _results = [];
  List _filters = [
    'scope:types',
    'author:sindresorhus',
    'maintainer:sindresorhus',
    'keywords:gulpplugin',
    'not:deprecated',
    'not:unstable',
    'not:insecure',
    'is:deprecated',
    'is:unstable',
    'is:insecure',
    'boost-exact:false',
    'score-effect:14',
    'quality-weight:1',
    'popularity-weight:1',
    'maintenance-weight:1'
  ];
  bool _isSearching = false;
  bool _isLoadingMore = false;

//  List<Suggestion> _suggestions = <Suggestion>[];
  TextEditingController _textEditingController = new TextEditingController();
  ScrollController _listViewController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _searchResults() {
    if (_input.isEmpty || _input == '') {
      return;
    }
    if (_input == _prevInput) {
      return;
    }
    setState(() {
      _isSearching = true;
      _prevInput = _input;
      _results.clear();
    });
    request.getSearchResults(_input, _pageIndex).then((res) {
      setState(() {
        _total = res['total'];
        for (var item in res['results']) {
          _results.add(item);
        }
        _isSearching = false;
      });
      _textEditingController.clear();
    }).catchError((err) {
      setState(() {
        _isSearching = false;
      });
      new SimpleDialog(
        title: Text('加载失败，请重试'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: _searchResults,
            child: Text('确定'),
          )
        ],
      );
    });
  }

  void _loadMore() {
    if (_isLoadingMore) {
      return;
    }
    _pageIndex++;
    setState(() {
      _isLoadingMore = true;
    });
    request.getSearchResults(_input, _pageIndex).then((res) {
      setState(() {
        _total = res['total'];
        for (var item in res['results']) {
          _results.add(item);
        }
        _isLoadingMore = false;
      });
      _textEditingController.clear();
    }).catchError((err) {
      setState(() {
        _isLoadingMore = false;
      });
      new SimpleDialog(
        title: Text('加载失败，请重试'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: _loadMore,
            child: Text('确定'),
          )
        ],
      );
    });
  }

  void _showSuggestions() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autocorrect: false,
          autofocus: true,
          controller: _textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '搜索',
            hintStyle: TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
            ),
          ),
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.0,
            decoration: TextDecoration.none,
          ),
          onChanged: (val) {
            setState(() {
              _input = val;
            });
            _showSuggestions();
          },
          onSubmitted: (String val) {
            _searchResults();
          },
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return _filters.map((f) {
                return PopupMenuItem(
                  value: f,
                  child: SwitchListTile(
                    title: Text(f),
                    value: false,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                );
              }).toList();
            },
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Stack(children: [
        AnimatedCrossFade(
          firstChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NotificationListener(
              onNotification: (ScrollNotification note) {
                if (note.metrics.maxScrollExtent == note.metrics.pixels) {
                  _loadMore();
                }
              },
              child: ListView.builder(
                shrinkWrap: true,
                controller: _listViewController,
                itemCount: _results.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardResult(_results[index]);
                },
              ),
            ),
          ),
          secondChild: LinearProgressIndicator(),
          crossFadeState: _isSearching ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300),
        ),
        _isLoadingMore ? Center(child: CircularProgressIndicator()) : Container(),
      ]),
    );
  }
}
