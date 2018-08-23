import 'package:flutter/material.dart';
import 'package:flutter_npm_search/model/history.dart';
import 'package:flutter_npm_search/model/result.dart';
import 'package:flutter_npm_search/model/suggestion.dart';
import 'package:flutter_npm_search/page/detail.dart';
import 'package:flutter_npm_search/request/request.dart';
import 'package:flutter_npm_search/widget/card_result.dart';

Request request = new Request();

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _total = 0;
  List _results = [];
  bool _isSearching = false;
  List<Suggestion> _suggestions = <Suggestion>[];
  TextEditingController _textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void showSuggestions() {}

  void showSnackBar(int total) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(_total.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.search,
                size: 28.0,
                color: Colors.white70,
              ),
            ),
            filled: true,
            border: InputBorder.none,
            hintText: '搜索',
            hintStyle: TextStyle(
              color: Colors.white70,
              fontSize: 16.0,
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
            print('Change: $val');
            showSuggestions();
          },
          onSubmitted: (String val) {
            setState(() {
              _isSearching = true;
            });
            if (val.isNotEmpty) {
              request.getSearchResults(val).then((res) {
                setState(() {
                  print(res['total']);
                  _total = res['total'];
                  _results = res['results'];
                  _isSearching = false;
                });
                _textEditingController.clear();
                showSnackBar(_total);
              });
            }
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            iconSize: 28.0,
            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage('react')));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _isSearching ? LinearProgressIndicator() : Container(),
          AnimatedCrossFade(
            firstChild: ListView.builder(
              shrinkWrap: true,
              itemCount: _results.length,
              itemBuilder: (BuildContext context, int index) {
                return CardResult(_results[index]);
              },
            ),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: GridView.count(
                crossAxisCount: 6,
                primary: false,
                children: <Widget>[
                  new ChipHistory(History('rect')),
                  new ChipHistory(History('vue')),
                  new ChipHistory(History('express')),
                  new ChipHistory(History('koa')),
                  new ChipHistory(History('angular')),
                  new ChipHistory(History('nest.js')),
                  new ChipHistory(History('d3')),
                  new ChipHistory(History('jQuery')),
                ],
              ),
            ),
            crossFadeState:
            _results.isNotEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

class ChipHistory extends StatelessWidget {
  final History histoty;

  ChipHistory(this.histoty);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ActionChip(
        label: new Text(histoty.name),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailPage(histoty.name)),
          );
        },
      ),
    );
  }
}
