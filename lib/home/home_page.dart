import 'package:flutter/material.dart';
import 'package:flutter_dome/home/widget/widget_drow_progress.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _delayedGoHomePage();
  }

  _delayedGoHomePage() {
    Future.delayed(new Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/login",
        (Route<dynamic> route) => false
      );
    });
  }

  _clickJeep() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/login",
      (Route<dynamic> route) => false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: new Image.asset(
              "images/ic_launcher.png",
              // fit: BoxFit.cover,
            ),
            constraints: new BoxConstraints.expand(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.all(30),
              child: SkipDownTimeProgress(
                Colors.red,
                22.0,
                new Duration(seconds: 2),
                new Size(25.0, 25.0),
                skipText: "跳过",
                clickListener: _clickJeep,
              ),
            ),
          ),
        ],
      ), // 构建主页面
    );
  }
}
