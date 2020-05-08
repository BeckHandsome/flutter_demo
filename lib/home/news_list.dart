import 'package:flutter/material.dart';
import 'package:flutter_dome/utils/net_util.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class NewsList extends StatefulWidget {
  final int newsType;
  NewsList({Key key, this.newsType = 0}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List _dataList = [];
  int _startPage = 20;
  int _newType = 0;
  bool _isShowLoading = false;
  Future _get() async {
    _isShowLoading = true;
    DioUtil().get(
      NWApi.news,
      pathParams: {"type": _newType, "page": _startPage},
    ).then((e) {
      if (e["msg"] == "success") {
          setState(() {
            _dataList.addAll(e["data"]);
          });
      }
        _isShowLoading = false;
    });
  }

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newType = widget.newsType;
    _get();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: <Widget>[
          _isShowLoading
              ? Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                )
              : EasyRefresh(
                  onRefresh: () async {
                    _dataList = [];
                    _startPage = 20;
                    _get();
                  },
                  onLoad: () async {
                    _startPage += 10;
                    _get();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              if (_dataList.length <= 3) {
                                return Center(
                                  child: Text("连网失败"),
                                );
                              }
                              return (Image.network(
                                "${_dataList[index]['imgsrc']}",
                                fit: BoxFit.fill,
                              ));
                            },
                            itemCount: 3,
                            pagination: new SwiperPagination(
                                builder: DotSwiperPaginationBuilder(
                              color: Colors.black54,
                              activeColor: Colors.white,
                            )),
                            control: new SwiperControl(),
                            scrollDirection: Axis.horizontal,
                            autoplay: true,
                            onTap: (index) => Navigator.pushNamed(
                                context, "/news_detail",
                                arguments: {
                                  "url": _dataList[index]["url"],
                                }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: List.generate(
                              _dataList.length,
                              (index) => GestureDetector(
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
                                            child: SizedBox(
                                              height: 100,
                                              child: Image.network(
                                                "${_dataList[index]["imgsrc"]}",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
