
import 'package:flutter/material.dart';
import 'package:flutter_dome/home/widget/widget_table.dart';

class TableList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTable(
        [
          {
            "time": '1月',
            "currentData": '65.4',
            "frontData": '65.4',
            "a": '65.4',
            "s": '65.4',
            "d": '65.4',
          },
          {
            "time": '2月',
            "currentData": '65.4',
            "frontData": '65.4',
            "a": '65.4',
            "s": "+60",
            "d": '65.4',
          },
          {
            "time": '2月',
            "currentData": '65.4',
            "frontData": '65.4',
            "a": '65.4',
            "s": "+60",
            "d": '-65.4',
          },
        ],
        [
          CustomTableColumn("序号", "time"),
          CustomTableColumn("本期", "currentData", unit: "kWh"),
          CustomTableColumn("去年同期", "frontData", unit: "kWh"),
          CustomTableColumn("增值", "a", unit: "kWh"),
          CustomTableColumn(
            "同比",
            "s",
            unit: "%",
          ),
          CustomTableColumn("累计同比", "d", unit: "%", colorFun: (item) {
            if (double.parse(item) > 0) {
              return Colors.red;
            } else {
              return Colors.green;
            }
          }),
        ],
      ),
      ],
    );
  }
}
