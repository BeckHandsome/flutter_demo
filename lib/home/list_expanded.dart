import 'package:flutter/material.dart';

class ExpandedList extends StatefulWidget {
  final bool isExpanded; //默认是否展开
  final bool isExpandedIcon; //是否只需要图标 或者图标加文字
  final bool isShowbutton; //展开后是否为button按钮
  final Map expandedData; //展开收起数据
  final Function onTapChild; //点击展开后的节点
  final Function onTapParent; //点击展开后的节点
  ExpandedList(
      {Key key,
      this.isExpanded = false,
      this.isExpandedIcon = true,
      this.isShowbutton = false,
      this.onTapChild,
      this.onTapParent,
      this.expandedData = const {
        "name": "haha",
        "children": [
          {
            "name": "101",
          },
          {
            "name": "102",
          },
          {
            "name": "103",
          },
          {
            "name": "104",
          }
        ]
      }})
      : super(key: key);

  @override
  _ExpandedListState createState() => _ExpandedListState();
}

class _ExpandedListState extends State<ExpandedList> {
  bool _isExpanded = false;
  bool _isShowbutton = false;
  Map _expandedData = {};
  void initState() {
    super.initState();
    //初始化状态
    _isExpanded = widget.isExpanded;
    _expandedData = widget.expandedData;
    _isShowbutton = widget.isShowbutton;
  }

  // 展开收起图标展示
  Widget _expandedIcon(bool iconBool) {
    switch (iconBool) {
      case false:
        return Row(
          children: <Widget>[
            Icon(Icons.chevron_right, color: Color(0xFF3190E1)),
            widget.isExpandedIcon
                ? Text(
                    "展开",
                    style: TextStyle(color: Color(0xFF3190E1)),
                  )
                : Text("")
          ],
        );
        break;
      default:
        return Row(
          children: <Widget>[
            Icon(Icons.chevron_right, color: Color(0xFF3190E1)),
            widget.isExpandedIcon
                ? Text(
                    "收起",
                    style: TextStyle(color: Color(0xFF3190E1)),
                  )
                : Text("")
          ],
        );
    }
  }

  // 展示button数据
  Widget _widgetButtonData() {
    List buttonList = [];
    Widget _content;
    if (_expandedData["children"] == null ||
        _expandedData["children"].length == 0) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          border: Border(
            top: BorderSide(width: 1, color: Color(0xFFDDDDDD)),
          ),
        ),
        child: ListTile(
          title: Center(
            child: Text("暂无数据"),
          ),
        ),
      );
    }
    for (var item in _expandedData["children"]) {
      buttonList.add(
        OutlineButton(
          color:  Color(0xFFF5F7FF),
          textColor: Color(0xFF3190E1),
          borderSide: BorderSide(color: Color(0xFF3190E1),width: 1,style: BorderStyle.solid),
          child: Text(item["name"]),
          onPressed: () {
          },
        ),
      );
    }
    _content = Wrap(
      spacing: 10, //主轴上子控件的间距
      runSpacing: 0, //交叉轴上子控件之间的间距
      alignment: WrapAlignment.start,
      children: [...buttonList],
    );
    return _content;
  }

  //展示列表数据
  Widget _widgetListData() {
    List dataList = [];
    Widget _content;
    if (_expandedData["children"] == null ||
        _expandedData["children"].length == 0) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          border: Border(
            top: BorderSide(width: 1, color: Color(0xFFDDDDDD)),
          ),
        ),
        child: ListTile(
          title: Center(
            child: Text("暂无数据"),
          ),
        ),
      );
    }
    for (var item in _expandedData["children"]) {
      dataList.add(
        DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border(
              top: BorderSide(width: 1, color: Color(0xFFDDDDDD)),
            ),
          ),
          child: ListTile(
            onTap: () {
              if (widget.onTapChild != null) {
                widget.onTapChild(item);
              }
            },
            title: Text(item["name"]),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
      );
    }
    _content = Column(
      children: [...dataList],
    );
    return _content;
  }

  // 渲染数据
  Widget _buildGrid() {
    switch (_isShowbutton) {
      case true:
        return _widgetListData();
        break;
      default:
        return _widgetButtonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xFFDDDDDD)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                  if (widget.onTapParent != null) {
                    widget.onTapParent();
                  }
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${_expandedData["name"]}",
                      // style: TextStyle(color: Color(0xFF3190E1)),
                    ),
                    _expandedIcon(_isExpanded),
                  ],
                ),
              ),
              Visibility(
                visible: _isExpanded,
                child: _buildGrid(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
