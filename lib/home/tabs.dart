import 'package:flutter/material.dart';
import 'package:flutter_dome/home/news.dart';
import 'package:flutter_dome/home/my.dart';
import 'package:flutter_dome/home/ThirdPage.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  List _pageList = [
    ThirdPage(),
    News(),
    My(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: Image.asset("images/ic_launcher.png",width: 40,),),
        title: Text("myapp"),
      ),
	  body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, //配置对应的索引值选中
        onTap: (int index) {
          setState(() {
            //改变状态
            _currentIndex = index;
          });
        },
        iconSize: 16.0, //icon的大小
        fixedColor: Colors.red, //选中的颜色
        type: BottomNavigationBarType.fixed, //配置底部tabs可以有多个按钮
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("首页"),
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("新闻"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("我的"),
          ),
        ],
      ),
    );
  }
}
