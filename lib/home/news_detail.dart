import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  final Map params;
  NewsDetail({Key key,this.params}) : super(key: key);
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  String stringUrl = "";
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.params);
    stringUrl = widget.params["url"];
  }
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: new Text("新闻详情"),
        ),
        body: WebView(
          initialUrl: "$stringUrl",
         javascriptMode: JavascriptMode.unrestricted,
         onWebViewCreated: (controller) {
              _controller = controller;
            },
            navigationDelegate: (NavigationRequest request) {
              print(request);
              return NavigationDecision.navigate;
            } ,
        )
    );
  }
}
