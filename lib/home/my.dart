import 'package:flutter/material.dart';

class My extends StatelessWidget {
  final List listData = [
    {"title": "折叠面板","id": 0},
    {"title": "provider状态管理","id": 1},
    {"title": "listSwitch","id": 2},
    {"title": "tree","id": 3},
    {"title": "table","id": 4},
    {"title": "单选按钮","id": 5},
    {"title": "抽屉","id": 6},
    {"title": "发送通知","id": 7},
    {"title": "echarts","id": 8},
    {"title": "sliverHeader","id": 9},
  ];
  @override
  Widget build(BuildContext context) {
    Widget divider1=Divider(color: Colors.blue,);
    Widget divider2=Divider(color: Colors.green);
    return Scaffold(
      body: Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  trailing: Icon(Icons.chevron_right),
                  title: Text(listData[index]["title"]),
                  onTap: () {
                    Navigator.pushNamed(context, "/router_example", arguments:{"parmas": listData[index],});
                  }
              );
            },
            itemCount: listData.length,
            //分割器构造器
            separatorBuilder: (BuildContext context, int index) {
              return index%2==0?divider1:divider2;
            },
            ),
          ),
        ],
      ),
    ),
    );
  }
}
