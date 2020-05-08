import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dome/home/news_list.dart';
import 'package:flutter_dome/home/toast.dart';
import 'package:flutter_dome/utils/net_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:amap_location/amap_location.dart';
class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with TickerProviderStateMixin {
  TabController _tabController;
  List _weather = [];
  List _tabs = [];
  String _city = "北京市";
  final _permission = Permission.location;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabs = [
      {"name": "头条", "id": 0},
      {"name": "军事", "id": 1},
      {"name": "娱乐", "id": 2},
      {"name": "体育", "id": 3},
      {"name": "科技", "id": 4},
      {"name": "艺术", "id": 5},
      {"name": "教育", "id": 6},
      {"name": "要闻", "id": 7},
    ];
    _tabController = TabController(length: _tabs.length, vsync: this);
    requestPermission(_permission);
    
  }
  Future<void> requestPermission(Permission permission) async {
    // if ( await permission.status == PermissionStatus.undetermined) {
    //     Toast.toast(context, msg: "请手动打开定位功能");
    //     return;
    // }
    if(await permission.status == PermissionStatus.granted) {
      await AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters  ));
       var res = await AMapLocationClient.getLocation(true);
         _city = res.city;
        _getWeath();
      return;
    }else {
      final status = await permission.request();
      if(status == PermissionStatus.granted) {
          await AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters  ));
          var res = await AMapLocationClient.getLocation(true);
        _city = res.city;
        _getWeath();
      }
    }
    
  }
  Future _getWeath() async {
    DioUtil().get(
      NWApi.weather,
      pathParams: {"city": _city},
    ).then((e) {
      if (e["msg"] == "success") {
        setState(() {
          _weather.add(e["data"]["results"]);
        });
      }
    });
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Material(
            color: Colors.black,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: TabBar(
                    labelColor: Colors.white,
                    isScrollable: true,
                    controller: _tabController,
                    tabs: _tabs
                        .map(
                          (i) => Tab(
                            text: "${i['name']}",
                          ),
                        )
                        .toList()),
              ),
            ),
          ),
          Column(
            children: List.generate(
              _weather.length,
              (index) => Flex(direction: Axis.horizontal, children: <Widget>[
                Text("${_weather[index][0]['currentCity']}"),
                Text(" ${_weather[index][0]['weather_data'][0]["date"]} "),
                Text(" ${_weather[index][0]['weather_data'][0]["weather"]}"),
              ]),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(_tabs.length, (index) {
                return NewsList(newsType: _tabs[index]["id"]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
