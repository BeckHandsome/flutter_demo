import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  final List item;
  final Function callback;
  final String titleKey;
  final String typeKey;
  RadioButton({
    Key key,
    this.item,
    this.titleKey = "title",
    this.typeKey = "type",
    @required this.callback,
  }) : super(key: key);
  @override
  _RadioButtonState createState() => new _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  List _radioButtonList = [
    {
      "title": "日",
      "type": 0,
    },
    {"title": "周", "type": 1},
    {"title": "月", "type": 2},
    {"title": "年", "type": 3},
  ];
  int groupValue = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _radioButtonList = widget.item != null ? widget.item : _radioButtonList;
  }

  void _onTap(v) {
    setState(() {
      groupValue = v[widget.typeKey];
    });
    widget.callback(v);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(5.0),
      //一行多少个
      crossAxisCount: 3,
      // 左右间隔
      crossAxisSpacing: 10.0,
      // 上下间隔
      mainAxisSpacing: 10.0,
      //宽高比
      childAspectRatio: 1 / 0.3,
      shrinkWrap: true,
      children: _radioButtonList.map((value) {
        return GestureDetector(
          onTap: () {
            _onTap(value);
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: groupValue != value['type']
                    ? Border.fromBorderSide(BorderSide.none)
                    : Border.all(width: 1.0, color: Color(0xff3190E1)),
                borderRadius: BorderRadius.circular(2),
                color: Color(0xffF0F1F5)),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "${value[widget.titleKey]}",
                style: TextStyle(
                  color: groupValue == value[widget.typeKey]
                      ? Color(0xff3190E1)
                      : Color(0xff333333),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
