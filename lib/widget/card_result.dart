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
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          title: Text('${result.name}/${result.version}'),
          subtitle: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          result.package['publisher']['username'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Text(result.publish),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  result.description == null ? '' : result.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(height: 1.2),
                ),
              ),
            ],
          ),
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
