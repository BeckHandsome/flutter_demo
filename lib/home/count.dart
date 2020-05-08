import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/**
 * 
 * 数据共享实现简单计数
 * 
 * 
 */
import 'package:provider/provider.dart';
import '../provider/counter.dart';

class Count extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Column(
      children: <Widget>[
        Builder(builder: (context) {
          return RaisedButton(
            onPressed: () {
              counter.increment();
            },
            child: Text("点我增加"),
          );
        }),
         Builder(builder: (context) {
          return RaisedButton(
            onPressed: () {
              counter.decrement();
            },
            child: Text("点我减少"),
          );
        }),
        Text("counter 的值:${counter.count}"),
      ],
    );
  }
}
