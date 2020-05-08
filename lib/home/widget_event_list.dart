import 'package:flutter/material.dart';
import 'package:flutter_dome/style/style.dart';

class EventList extends StatefulWidget {
  EventList({
    Key key,
    this.listData = const [], //事件列表参数  最多传入三个列表
  }) : super(key: key);
  final List listData;
//   [
//       {
//         "type": 0, //类型 0 告警 1故障 2离线
//         "occurrenceTime": "2019-07-17  13:00:00", //发生时间
//         "details": "A相电流过流", //事件详情
//         "status": 1, //状态 0 恢复 1未恢复
//         "timeDuration": "12:01:59", //持续时间
//         "recoveryTime": "", //恢复时间
//         "grade": 0, //等级 0 紧急  1重要 2 一般
//       },
// 	]
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List _listData;

  void initState() {
    super.initState();
    //初始化状态
    _listData = widget.listData;
  }

  Widget buildGrid() {
    // _listData = [
    //   {
    //     "type": 0, //类型 0 告警 1故障 2离线
    //     "occurrenceTime": "2019-07-17  13:00:00", //发生时间
    //     "details": "A相电流过流", //事件详情
    //     "status": 1, //状态 0 恢复 1未恢复
    //     "timeDuration": "12:01:59", //持续时间
    //     "recoveryTime": "", //恢复时间
    //     "grade": 0, //等级 0 紧急  1重要 2 一般
    //   },
    //   {
    //     "type": 1, //类型 0 告警 1故障 2离线
    //     "occurrenceTime": "2019-07-17  13:00:00", //发生时间
    //     "details": "A相电流欠流", //事件详情
    //     "status": 0, //状态 0 恢复 1未恢复
    //     "timeDuration": "12:01:59", //持续时间
    //     "recoveryTime": "12:05:00", //恢复时间
    //     "grade": 1,
    //   },
    //   {
    //     "type": 2, //类型 0 告警 1故障 2离线
    //     "occurrenceTime": "2019-07-17  13:00:00", //发生时间
    //     "details": "设备离线", //事件详情
    //     "status": 0, //状态 0 恢复 1未恢复
    //     "timeDuration": "12:01:59", //持续时间
    //     "recoveryTime": "12:05:00", //恢复时间
    //     "grade": 2,
    //   },
    // ];
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget

    if (_listData.length <= 0 || _listData == null) {
      tiles.add(Center(
        child: Text("当前设备无事件"),
      ));
    } else {
      for (var item in _listData) {
        var typeStr =
            item["type"] == 0 ? "告警" : item["type"] == 1 ? "故障" : "离线";
        var statusStr = item["status"] == 0 ? "恢复" : "未恢复";
        var colorStr = item["type"] == 0
            ? BasicsStyle.alarmColor
            : item["type"] == 1
                ? BasicsStyle.faultColor
                : BasicsStyle.offLineColor;
        var gradeStr =
            item["grade"] == 0 ? "紧急" : item["grade"] == 1 ? "重要" : "一般";
        var gradeColor = item["grade"] == 0
            ? BasicsStyle.urgencyColor
            : item["grade"] == 1
                ? BasicsStyle.importantColor
                : BasicsStyle.generalColor;
        tiles.add(
          DecoratedBox(
            decoration: BoxDecoration(
              color: BasicsStyle.white,
              border: Border(
                bottom: BasicsStyle.borderSideBottom1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Positioned(
                    top: 6.0,
                    left: 16.0,
                    child: SizedBox(
                      height: 10.0,
                      width: 10.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: colorStr,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 24.0,
                          ),
                          child: Text(
                            "设备" + typeStr + "（" + statusStr + "）",
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 24.0,
                          ),
                          child: Text(
                            "事件详情：" + item["details"],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 24.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "发生时间：",
                                style: TextStyle(color: BasicsStyle.eventColor),
                              ),
                              Text(item["occurrenceTime"])
                            ],
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 24.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "持续时间：",
                                style: TextStyle(color: BasicsStyle.eventColor),
                              ),
                              Text(item["timeDuration"])
                            ],
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 24.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "恢复时间：",
                                style: TextStyle(color: BasicsStyle.eventColor),
                              ),
                              Text(item["recoveryTime"])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SizedBox(
                      height: 20.0,
                      width: 60.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: gradeColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          gradeStr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: BasicsStyle.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    content = new Column(
        children: tiles //重点在这里，因为用编辑器写Column生成的children后面会跟一个<Widget>[]，
        //此时如果我们直接把生成的tiles放在<Widget>[]中是会报一个类型不匹配的错误，把<Widget>[]删了就可以了
        );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 7.0, 16.0, 7.0),
            color: Color(0xFFF0F1F5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    "当前事件",
                  ),
                ),
                GestureDetector(
                  child: Text(
                    "查看",
                    style: TextStyle(color: Color(0xFF3190E1)),
                  ),
                  onTap: () {
                    print("点击了查看");
                  },
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity, //宽度尽可能大
              //   maxHeight: 420.0,
            ),
            child: DecoratedBox(
              // 实时状态内容
              decoration: BoxDecoration(
                color: BasicsStyle.white,
              ),
              child: buildGrid(),
            ),
          )
        ],
      ),
    );
  }
}
