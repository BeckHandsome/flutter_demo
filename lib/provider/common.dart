

import 'package:flutter/material.dart';

class InheritedProvider<T> extends InheritedWidget{
  InheritedProvider({@required this.data, Widget child}): super(child: child);

  // 共享状态使用泛型
  final T data;

  bool updateShouldNotify(InheritedProvider<T> old){
    // 返回true，则每次更新都会调用依赖其的子孙节点的didChangeDependencies
    return true;
  }
}


// 该方法用于Dart获取模板类型
Type _typeOf<T>() => T;

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget{
  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child,
  });

  final Widget child;
  final T data;

  // 定义一个便捷方法，方便子树中的widget获取共享数据
//  static T of<T>(BuildContext context){
//    final type = _typeOf<InheritedProvider<T>>();
//    final provider = context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>;
//    return provider.data;
//  }

  // 替换上面的便捷方法，按需求是否注册依赖关系
  static T of<T>(BuildContext context, {bool listen = true}){
    final type = _typeOf<InheritedProvider<T>>();
    final provider = listen
        ? context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>
        : context.ancestorInheritedElementForWidgetOfExactType(type)?.widget as InheritedProvider<T>;
    return provider.data;
  }

  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();

}


// _ChangeNotifierProviderState类的主要作用就是监听到共享状态（model）改变时重新构建Widget树。
// 注意，在_ChangeNotifierProviderState类中调用setState()方法，widget.child始终是同一个，
// 所以执行build时，InheritedProvider的child引用的始终是同一个子widget，
// 所以widget.child并不会重新build，这也就相当于对child进行了缓存！当然如果ChangeNotifierProvider父级Widget重新build时，则其传入的child便有可能会发生变化。
class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>>{
  void update(){
    // 如果数据发生变化（model类调用了notifyListeners)，重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget){
    // 当Provider更新时，如果新旧数据不相等，则解绑旧数据监听，同时添加新数据监听
    if(widget.data != oldWidget.data){
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState(){
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose(){
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }

}
