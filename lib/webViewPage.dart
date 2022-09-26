import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class WebViewBlogs extends StatefulWidget {
  String url;
  WebViewBlogs({@required this.url});

  @override
  _WebViewBlogsState createState() => _WebViewBlogsState();
}

class _WebViewBlogsState extends State<WebViewBlogs> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController webViewController;
  @override
  Widget build(BuildContext context) {
    // print(widget.url)
    return SafeArea(
        child: Scaffold(
      body: WebView(
        navigationDelegate: (NavigationRequest req) {},

        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.url, //shop.teamsg.in
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    ));
  }
}
