
import 'package:flutter/material.dart';
import '../provider/count_cart_provider.dart';
import '../provider/common.dart';
// 优化
// 一个便捷类，封装一个Consumer的Widget
//Consumer实现非常简单，它通过指定模板参数，然后再内部自动调用ChangeNotifierProvider.of获取相应的Model，并且Consumer这个名字本身也是具有确切语义（消费者）
class Consumer<T> extends StatelessWidget{
  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  Consumer({
    Key key,
    @required this.builder,
    this.child,
  }): assert(builder != null),
      super(key: key);

  Widget build(BuildContext context){
    return builder(
      context,
      // 自动获取Model
      ChangeNotifierProvider.of<T>(context),
    );
  }
}


// 页面
class ProviderRoute extends StatefulWidget{
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute>{
  @override
  Widget build(BuildContext context){
    return Container(
      child: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(builder: (context){
            return Column(
              children: <Widget>[
//                Builder(builder: (context){
//                  var cart = ChangeNotifierProvider.of<CartModel>(context);
//                  return Text("总价：${cart.totalPrice}");
//                },),

              // 进行优化，替换上面Builder
                Consumer<CartModel>(
                  builder: (context, cart) => Text("总价：${cart.totalPrice}"),
                ),

                Builder(builder: (context){
                  // 控制台打印出这句，说明按钮在每次点击时其自身都会重新build！
                  print("RaisedButton build");
                  return RaisedButton(
                    child: Text("添加商品"),
                    onPressed: (){
                      // 给购物车中添加商品，添加后总价会更新
//                      ChangeNotifierProvider.of<CartModel>(context).add(Item(20.0, 1));
                      // listen设为false，不建立依赖关系，因为按钮不需要每次重新build
                      ChangeNotifierProvider.of<CartModel>(context, listen: false).add(Item(20.0, 1));
                    },
                  );
                },)
              ],
            );
          },),
        ),
      ),
    );
  }
}