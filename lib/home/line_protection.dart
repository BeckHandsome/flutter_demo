import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LineProtectionRoute extends StatefulWidget {
  @override
  State createState() => _LineProtectionRouteState();
}

class _LineProtectionRouteState extends State<LineProtectionRoute>
    with SingleTickerProviderStateMixin {
 final listData = [
		{
      "title": "合闸",
      "img": "images/4.png",
      "detail": "短路器位置",
    },
    {
      "title": "工作位",
      "img": "images/10.png",
      "detail": "手车位置",
    },
    {
      "title": "远方",
      "img": "images/1.png",
      "detail": "本地/远方",
    },
    {
      "title": "断线",
      "img": "images/8.png",
      "detail": "控制回路状态",
    },
    {
      "title": "运行",
      "img": "images/11.png",
      "detail": "运行/检修",
    },
    {
      "title": "未储能",
      "img": "images/1.png",
      "detail": "储能弹簧状态",
    },
    {
      "title": "分闸",
      "img": "images/7.png ",
      "detail": "接地刀位置",
    },
];
  final formList = [
    {
      "type": 0, //类型 0 告警 1故障 2离线
      "occurrenceTime": "2019-07-17  13:00:00", //发生时间
      "details": "A相电流过流", //事件详情
      "status": 1, //状态 0 恢复 1未恢复
      "timeDuration": "12:01:59", //持续时间
      "recoveryTime": "", //恢复时间
      "grade": 0, //等级 0 紧急  1重要 2 一般
    },
    {
      "type": 1, //类型 0 告警 1故障 2离线
      "occurrenceTime": "2019-07-17  13:00:00", //发生时间
      "details": "A相电流欠流", //事件详情
      "status": 0, //状态 0 恢复 1未恢复
      "timeDuration": "12:01:59", //持续时间
      "recoveryTime": "12:05:00", //恢复时间
      "grade": 1,
    },
    {
      "type": 2, //类型 0 告警 1故障 2离线
      "occurrenceTime": "2019-07-17  13:00:00", //发生时间
      "details": "设备离线", //事件详情
      "status": 0, //状态 0 恢复 1未恢复
      "timeDuration": "12:01:59", //持续时间
      "recoveryTime": "12:05:00", //恢复时间
      "grade": 2,
    },
    {
      "type": 2, //类型 0 告警 1故障 2离线
      "occurrenceTime": "2019-07-17  13:00:00", //发生时间
      "details": "A相电流过流", //事件详情
      "status": 0, //状态 0 恢复 1未恢复
      "timeDuration": "12:01:59", //持续时间
      "recoveryTime": "12:05:00", //恢复时间
      "grade": 0,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: new CustomScrollView(
        slivers: <Widget>[
          //   ),
          new SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: SliverGrid(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                // mainAxisSpacing: 10.0,
                // crossAxisSpacing: 10.0,
                childAspectRatio: 3.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget
                  return new Container(
                    alignment: Alignment.center,
                    color: Color(0xFFFFFFFF),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 60.0,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xFFDDDDDD)),
                                  right: BorderSide(
                                      width: 1, color: Color(0xFFDDDDDD))),
                            ),
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Image(
                                    image: AssetImage("images/1.png"),
                                    height: 36.0,
                                    width: 36.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(listData[index]["title"],
                                        style: TextStyle(fontSize: 14.0)),
                                    Text("接地刀位置",
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
                },
                childCount: listData.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
