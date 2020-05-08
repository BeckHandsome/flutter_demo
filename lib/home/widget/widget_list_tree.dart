import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTree extends StatefulWidget {
  ListTree({
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
  _ListTreeState createState() => _ListTreeState();
}

class _ListTreeState extends State<ListTree> {
  // bool _isExpaned = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // for (var item in widget.treeData) {
    //     // _expand(item);
    // }
  }

  // void _expand(item) {
  //   if (item["isExpaned"] == null) {
  //     if (_isExpaned) {
  //       item["isExpaned"] = true;
  //     } else {
  //       item["isExpaned"] = false;
  //     }
  //   }
  //   if (item[widget.childrenKey].length > 0) {
  //     for (var i in item[widget.childrenKey]) {
  //       _expand(i);
  //     }
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: widget.backgroundColor != null
            ? widget.backgroundColor
            : Color(0xFFFFFFFF),
      ),
      child: Column(
        children: List.generate(
          widget.treeData.length,
          (int index) {
            return Column(
              children: <Widget>[
                TreeNode(
                  item: widget.treeData[index],
                  labelKey: widget.labelKey,
                  childrenKey: widget.childrenKey,
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TreeNode extends StatefulWidget {
  final Map item;
  final String labelKey;
  final String childrenKey;

  const TreeNode({
    this.labelKey,
    this.childrenKey,
    @required this.item,
  }) : assert(item != null);

  @override
  _TreeNodeState createState() => _TreeNodeState();
}

class _TreeNodeState extends State<TreeNode>
    with SingleTickerProviderStateMixin {
  initState() {
    super.initState();
  }
  
  // 递归生成每个节点的深度
  void _b(item, {double depth = 0}) {
    item["depth"] = depth + 1;
    if (item[widget.childrenKey].length > 0) {
      for (var i in item[widget.childrenKey]) {
        _b(i, depth: depth + 1);
      }
    }
  }
  @override
  Widget build(BuildContext context) {

    final Map item = widget.item;
    final List children = item[widget.childrenKey];
    _b(item);
  
  
    return Column(
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFDDDDDD))),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print(item);
                    },
                    child: Text("${item[widget.labelKey]}"),
                  ),
                ),
                Visibility(
                  visible: children.length > 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        item["isExpaned"] = !item["isExpaned"];
                      });
                    },
                    child: item["isExpaned"] ? Text("收起") : Text("展开"),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: children.length > 0 && item["isExpaned"],
          child: Padding(
            padding: EdgeInsets.only(left: 0),
            child: Column(
              children: List.generate(
                children.length,
                (int index) {
                  return _TreeNode(children[index]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _TreeNode(Map item) {
    

    return Column(
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFDDDDDD))),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: item["depth"] == null ? 16 : item["depth"] * 16),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print(item);
                      },
                      child: Text("${item[widget.labelKey]}"),
                    ),
                  ),
                  Visibility(
                    visible: item["children"].length > 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          item["isExpaned"] = !item["isExpaned"];
                        });
                      },
                      child: item["isExpaned"] ? Text("收起") : Text("展开"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: item["children"].length > 0 && item["isExpaned"],
          child: Padding(
            padding: EdgeInsets.only(left: 0),
            child: Column(
              children: List.generate(
                item["children"].length,
                (int index) {
                  return _TreeNode(
                    item["children"][index],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
