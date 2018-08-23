import 'package:flutter/material.dart';
import 'package:flutter_npm_search/model/result.dart';
import 'package:flutter_npm_search/page/detail.dart';

class CardResult extends StatelessWidget {
  final Result result;

  CardResult(this.result);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          title: Row(
            children: <Widget>[
              Text(result.name),
            ],
          ),
          subtitle: Text(result.description),
          trailing: Text('${(result.score * 100).round().toString()}'),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailPage(result.name)),
          );
        },
      ),
    );
  }
}
