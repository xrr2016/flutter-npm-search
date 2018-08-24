import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage([this.url = '']);

  @override
  _WebViewPageState createState() => _WebViewPageState(url);
}

class _WebViewPageState extends State<WebViewPage> {
  final String _url;

  _WebViewPageState(this._url);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: _url,
      appBar: new AppBar(
        title: Text(
          _url,
          style: TextStyle(fontSize: 14.0),
        ),
      ),
      withZoom: true,
      withLocalStorage: true,
    );
  }
}
