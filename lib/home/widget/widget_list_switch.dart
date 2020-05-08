import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListSwich extends StatefulWidget {
  ListSwich(
      {Key key,
      this.backgroundColor,
      this.text,
      @required this.callBack,
      @required this.switchSelected})
      : super(key: key);
  final Color backgroundColor;
  final String text;
  final Function callBack;
  final bool switchSelected;
  _ListSwichState createState() => _ListSwichState();
}

class _ListSwichState extends State<ListSwich> {
  void _onTap(value) {
    widget.callBack(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor != null
            ? widget.backgroundColor
            : Color(0xFFFFFFFF),
      ),
      padding: EdgeInsets.fromLTRB(16, 0, 10, 0),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text("${widget.text != null ? widget.text : '标题'}"),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CupertinoSwitch(
                  activeColor: Color(0xFF14CE66),
                  value: widget.switchSelected, //当前状态
                  onChanged: (value) {
                    _onTap(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
