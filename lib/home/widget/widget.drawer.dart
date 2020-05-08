import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({
    Key key,
  }) : super(key: key);
  @override
  _MyDrawerState createState() => new _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: Drawer(
        child: Center(
          child: OutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("点我关闭抽屉"),
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Center(
          child: OutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("点我关闭抽屉"),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          OutlineButton(
            onPressed: () {
              _globalKey.currentState.openDrawer();
            },
            child: Text("点我打开左抽屉"),
          ),
          OutlineButton(
            onPressed: () {
              _globalKey.currentState.openEndDrawer();
            },
            child: Text("点我打开右抽屉"),
          ),
        ],
      ),
    );
  }
}
