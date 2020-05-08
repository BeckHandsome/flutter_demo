
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTable extends StatefulWidget {
  final List dataList;
  final List<CustomTableColumn> columns;

  CustomTable(this.dataList, this.columns, {Key key}) : super(key: key);

  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  List<DataRow> _buildRows(List list) {
    List<DataRow> rows = List();
    var listLength = list.length;
    for (var i = 0; i < listLength; i++) {
      var item = list[i];
      List<DataCell> cells = List();
      widget.columns.forEach((v) {
        return cells.add(
          DataCell(
            v.widgetFun(item, v),
          ),
        );
      });
      rows.add(
        DataRow(cells: cells),
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: DataTable(
        horizontalMargin: 16,
        dataRowHeight: 44,
        headingRowHeight: 44,
        columns: widget.columns
            .map((col) => DataColumn(
                  label: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        col.label,
                        style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Visibility(
                        visible: col.unit != "",
                        child: Text(
                          "(${col.unit})",
                          style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ))
            .toList(),
        rows: _buildRows(widget.dataList),
        columnSpacing: 5.0,
      ),
    );
  }
}

class CustomTableColumn {
  String label; //展示表头名称
  String field; //每一列对应的key
  String unit; //表头展示的单位 有展示没有不展示
  Function
      colorFun; //每列处理的颜色函数需要返回Color 当传入widgetFun 此时colorFun失效 调用colorFun：(v) {}
  Function widgetFun; //列展示内容不符合需求可以自定义内容 需要返回widget 调用widgetFun：(item,v) {}

 static Color colorFunDefault(v) => Colors.black;
  static Widget widgetFunDefault(item, v) => Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            item[v.field],
            style: TextStyle(
                color: v.colorFun(item[v.field]),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
        ],
      );

  CustomTableColumn(this.label, this.field,
      {this.unit = "", this.colorFun = colorFunDefault, this.widgetFun = widgetFunDefault}) {
    this.label = label ?? field;
    
  }

  CustomTableColumn.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    label = json['label'];
  }
}
