import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String newsUrl;

  ArticleView({this.newsUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //To center the object in the row
            children: <Widget>[
              Text(
                "News",
                style: TextStyle(color: Colors.blue),
              ),
              Text(
                "App",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          actions: <Widget>[
            Opacity(
              opacity: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.save)),
            )
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: WebView(
            initialUrl: widget.newsUrl,
            onWebViewCreated: (WebViewController webViewController) {
              _completer.complete(webViewController);
            },
          ),
        ));
  }
}
