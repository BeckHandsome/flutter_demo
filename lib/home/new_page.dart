import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  String _data;
  List _dataList = [];
  int _startNum = 0;
  int _endNum = 10;
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  var _futureBuilderFuture;
  getNew(int start, int end) async {
    try {
      //创建一个httpClient
      HttpClient httpClient = new HttpClient();
      // 打开http链接
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "http://c.m.163.com/nc/article/headline/T1348647853363/$start-$end.html"));
      //使用iPhone的UA
      request.headers.add("user-agent",
          "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
      //等待连接服务器（会将请求信息发送给服务器）
      HttpClientResponse response = await request.close();
      //读取响应内容
      _data = await response.transform(utf8.decoder).join();
      _dataList.addAll(jsonDecode(_data)["T1348647853363"]);
      //关闭client后，通过该client发起的所有请求都会中止。
      httpClient.close();
    } catch (e) {}
  }

  void initState() {
    super.initState();
    setState(() {
      _futureBuilderFuture = getNew(_startNum, _endNum);
    });

    _controller.addListener(() {
      // print(_controller.offset); //打印滚动位置
      if (_controller.offset < 500 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 500 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            child: FutureBuilder(
              future: _futureBuilderFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                  child: EasyRefresh(
                    onRefresh: () async {
                      setState(() {
                        _dataList = [];
                        _startNum = 0;
                        _endNum = 10;
                        _futureBuilderFuture = getNew(_startNum, _endNum);
                      });
                    },
                    onLoad: () async {
                      setState(() {
                        _startNum += 10;
                        _endNum += 10;
                        _futureBuilderFuture = getNew(_startNum, _endNum);
                      });
                    },
                    child: CustomScrollView(
                      controller: _controller,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: EdgeInsets.all(20),
                          sliver: SliverList(
                            delegate: (SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/news_detail",
                                      arguments: {
                                        "url": _dataList[index]["url"],
                                      });
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0, color: Color(0xFF999999)),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Flex(
                                        direction: Axis.horizontal,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                      "${_dataList[index]["title"]}"),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        "${_dataList[index]["source"]} ",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF888888)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Image.network(
                                                "${_dataList[index]["imgsrc"]}"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }, childCount: _dataList.length)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: showToTopBtn,
            child: Positioned(
              bottom: 20,
              right: 0,
              child: SizedBox(
                height: 40,
                child: RaisedButton(
                  color: Color(0x50000000),
                  textColor: Colors.white,
                  child: Center(child: Icon(Icons.arrow_upward),),
                  shape: CircleBorder(side: BorderSide(color: Color(0x50000000))),
                  onPressed: () {
                  //返回到顶部时执行动画
                  _controller.animateTo(.0,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.ease);
                }),
              ),),
          ),
        ],
      ),
    );
  }
}
