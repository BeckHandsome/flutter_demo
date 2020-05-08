import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dome/home/widget/widget_list_tree.dart';

class Tree extends StatefulWidget {
  Tree({
    Key key,
    this.backgroundColor,
    this.treeData,
    this.labelKey = 'label',
    this.childrenKey = 'children',
  }) : super(key: key);
  final Color backgroundColor;
  final List treeData;
  final String labelKey;
  final String childrenKey;
  _TreeState createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  bool _isExpaned = false;
  List _dataList = [
    {
      "name": "hahaah",
      "id": "1",
      "children": [
        {
          "name": "101",
          "id": "2",
          "children": [
            {
              "name": "102",
              "id": "3",
              "children": [
                {"name": "130", "id": "6", "children": []},
              ]
            },
            {
              "name": "102",
              "id": "4",
              "children": [
                {"name": "130", "id": "5", "children": []},
              ]
            },
          ]
        },
      ]
    },
    {
      "name": "ha222",
      "id": "11",
      "children": [
        {
          "name": "101",
          "id": "22",
          "children": [
            {
              "name": "102",
              "id": "33",
              "children": [
                {"name": "104", "id": "4", "children": []},
              ]
            },
          ]
        },
      ]
    },
  ];
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataList.forEach((item) {
      _expand(item);
    });
  }

  Map add = {}; //用于存储每个树下 搜索时匹配到的父节点id
  _searchName(List list, value) {
    list.forEach((item) {
      if (item["name"].contains(value)) {
        add[item["id"]] = {
          "isExpaned": true,
          "id": [item["id"]]
        };
      } else {
        add[item["id"]] = {
          "isExpaned": false,
          "id": [item["id"]]
        };
      }
      //循环子节点判断是否打开父节点去添加id
      if (item["children"].length > 0) {
        _expandInit(item["children"], value, item["id"]);
      } else {
        if (add[item["id"]]["isExpaned"] == false) {
          add[item["id"]] = null;
        }
      }
    });
    // 循环去生成哪些需要展开的树节点
    _parentExpand(list, _openCurrentchild(add));
  }
// 过滤搜索时匹配到的父节点id
  _expandInit(item, value, id) {
    item.forEach((el) {
      if (el["name"].contains(value)) {
        add[id]["isExpaned"] = true;
      } 
      add[id]["id"].addAll([el["id"]]);
      if (el["children"].length > 0) {
        this._expandInit(el["children"], value, id);
      }
    });
  }

  // 将搜索匹配到的id存在一个数组里方便后续循环整个树判断是否展开
  _openCurrentchild(initData) {
    
    List initArray = [];
    for (var key in initData.keys) {
      if (initData[key]["isExpaned"] == true) {
        initArray.addAll(initData[key]["id"]);
      }
    }
    
    return initArray;
  }

  void _parentExpand(items, list) {
    for (var item in items) {
      if (list.contains(item["id"])) { //判断是否包含id
        item["isExpaned"] = true;
      } else {
        item["isExpaned"] = false;
      }

      if (item["children"].length > 0) {
        _parentExpand(item["children"], list);
      }
    }
  }

  // 初始化
  void _expand(item) {
    if (item["isExpaned"] == null) {
      if (_isExpaned) {
        item["isExpaned"] = true;
      } else {
        item["isExpaned"] = false;
      }
    }
    if (item["children"].length > 0) {
      item["children"].forEach((item) {
        _expand(item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
          child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                filled: true,
                border: InputBorder.none,
                hintText: "关键字",
                prefixIcon: Icon(
                  Icons.search,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onChanged: (v) {
                setState(() {
                  add = {};
                  _searchName(_dataList, v);
                });
              }),
        ),
        ListTree(treeData: _dataList, labelKey: "name")
      ],
    );
  }
}
