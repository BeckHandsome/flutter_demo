import 'package:flutter/material.dart';
import 'package:flutter_dome/home/new_page.dart';
import './widget_event_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  // 需要显示的tab子项集合
  final List tabs = <Tab>[
    Tab(
      text: "1",
    ),
    Tab(
      text: "布局",
    ),
    Tab(
      text: "http请求的新闻",
    ),
  ];

// 对应上述tab切换后具体需要显示的页面内容
  final List tabBarViews = <Widget>[
    Container(
      alignment: Alignment.topLeft,
      color: Color(0xFFF0F1F5),
      child: Example(),
    ),
    Container(
      child: EasyRefresh(
        onRefresh: () async {},
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              //SliverList可以不设置高度的列表组件
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Text("wrap布局结合百分比布局实现一列俩个盒子沾满"),
                    Wrap(
                      // spacing: 8.0, // 主轴(水平)方向间距
                      // runSpacing: 4.0, // 纵轴（垂直）方向间距
                      children: <Widget>[
                        FractionallySizedBox(
                          widthFactor: 0.5,
                          child: Container(
                            height: 50,
                            color: Colors.red,
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.5,
                          child: Container(
                            height: 50,
                            color: Colors.blue,
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.5,
                          child: Container(
                            height: 50,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                    Text("stack布局中使用align"),
                    DecoratedBox(
                      decoration: BoxDecoration(color: Colors.green),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Stack(
                          children: <Widget>[
                            Text("我是stack内容部分"),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text("我被定位到盒子的中下了"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }, childCount: 1),
            ),
          ],
        ),
      ),
    ),
    Container(
      child: NewPage(),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController
        .addListener(() => print("当前点击的是第${_tabController.index}个tab"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Material(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.blue,
                  controller: _tabController,
                  tabs: tabs),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabBarViews,
            ),
          ),
        ],
      ),
    );
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return EventList(listData: [
              {
                "type": 0, //类型 0 告警 1故障 2离线
                "occurrenceTime": "2019-07-17  13:00:00", //发生时间
                "details": "11111", //事件详情
                "status": 1, //状态 0 恢复 1未恢复
                "timeDuration": "12:01:59", //持续时间
                "recoveryTime": "", //恢复时间
                "grade": 0, //等级 0 紧急  1重要 2 一般
              },
            ]);
          }, childCount: 1),
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              alignment: Alignment.topLeft,
              color: Color(0xFFFFFFFF),
              child: Wrap(
                // spacing: 8.0, // 主轴(水平)方向间距
                // runSpacing: 4.0, // 纵轴（垂直）方向间距
                children: <Widget>[
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Color(0xFFDDDDDD)),
                            right:
                                BorderSide(width: 1, color: Color(0xFFDDDDDD))),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image(
                              image: AssetImage("images/4.png"),
                              height: 36.0,
                              width: 36.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("title", style: TextStyle(fontSize: 14.0)),
                              Text("detail",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF999999))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Color(0xFFDDDDDD)),
                            right:
                                BorderSide(width: 1, color: Color(0xFFDDDDDD))),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image(
                              image: AssetImage("images/4.png"),
                              height: 36.0,
                              width: 36.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("title", style: TextStyle(fontSize: 14.0)),
                              Text("detail",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF999999))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Color(0xFFDDDDDD)),
                            right:
                                BorderSide(width: 1, color: Color(0xFFDDDDDD))),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image(
                              image: AssetImage("images/4.png"),
                              height: 36.0,
                              width: 36.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("title", style: TextStyle(fontSize: 14.0)),
                              Text("detail",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF999999))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }, childCount: 1),
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              color: Color(0xFFFFFFFF),
              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: RealTimeData(),
            );
          }, childCount: 3),
        ),
      ],
    );
  }
}

// 实时数据
class RealTimeData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<Widget> listData = [];
    return ListTile(
      leading: Image(
        image: AssetImage("images/1.png"),
        height: 36.0,
        width: 36.0,
        fit: BoxFit.contain,
      ),
      title: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("15.4", style: TextStyle(fontSize: 14.0)),
                    Text("AB",
                        style: TextStyle(
                            fontSize: 12.0, color: Color(0xFF999999))),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("15.4", style: TextStyle(fontSize: 14.0)),
                    Text("BC",
                        style: TextStyle(
                            fontSize: 12.0, color: Color(0xFF999999))),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("15.4", style: TextStyle(fontSize: 14.0)),
                    Text("CA",
                        style: TextStyle(
                            fontSize: 12.0, color: Color(0xFF999999))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        print("点击了实时数据");
      },
    );
  }
}
