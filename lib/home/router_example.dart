import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dome/home/echarts_page.dart';
import 'package:flutter_dome/home/list_expanded.dart';
import 'package:flutter_dome/home/permission.dart';
import 'package:flutter_dome/home/table.dart';
import 'package:flutter_dome/home/tree.dart';
import 'package:flutter_dome/home/widget/widget.drawer.dart';
import 'package:flutter_dome/home/widget/widget_list_switch.dart';
import 'package:flutter_dome/home/widget/widget_radio_button.dart';
import './count.dart';
import './count_cart.dart';

class RouterExample extends StatefulWidget {
  final Map params;
  RouterExample({
    Key key,
    this.params,
  }) : super(key: key);

  @override
  _RouterExampleState createState() => _RouterExampleState();
}

class _RouterExampleState extends State<RouterExample> {
  bool _switchSelected = true;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _buildGrad() {
    Widget content;
    switch (widget.params["parmas"]["id"]) {
      case 0:
        content = Column(
          children: <Widget>[
            ExpandedList(),
            ExpandedList(isShowbutton: true),
          ],
        );
        break;
      case 1:
        content = Column(
          children: <Widget>[Count(), ProviderRoute()],
        );
        break;
      case 2:
        content = ListSwich(
            switchSelected: _switchSelected,
            callBack: (value) {
              setState(() {
                _switchSelected = value;
              });
            });
        break;
      case 3:
        content = Tree();
        break;
      case 4:
        content = TableList();
        break;
      case 5:
        content = RadioButton(callback: (v) {});
        break;
      case 6:
        content = MyDrawer();
        break;
      case 7:
        content = Permissionsss();
        break;
      default:
        content = EchartsPage();
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.params["parmas"]["title"]}"),
      ),
      body: _buildGrad(),
    );
  }
}
