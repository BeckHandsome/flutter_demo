// 跨组件状态共享(Provider)


// 一个通用的InheritedWidget，保存任需要跨组件共享的状态
import 'dart:collection';

import 'package:flutter/material.dart';



// 购物车示例：实现一个显示购物车中所有商品总价的功能

// 用于表示商品信息
class Item{
  // 商品单价
  double price;
  // 商品份数
  int count;

  Item(this.price, this.count);

}


// 保存购物车内商品数据，跨组件共享
class CartModel extends ChangeNotifier{
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice => _items.fold(0, (value, item) => value + item.count * item.price);

  // 将[item]添加到购物车，这是唯一一种能从外部改变购物车的方法
  void add(Item item) {
    _items.add(item);
    // 通知监听者（订阅者），重新构建InheritedProvider，更新状态
    notifyListeners();
  }

}