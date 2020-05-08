import 'package:flutter/material.dart';

import 'package:flutter_dome/home/home.dart';
import 'package:flutter_dome/home/login.dart';
import 'package:flutter_dome/home/news.dart';
import 'package:flutter_dome/home/news_detail.dart';
import 'package:flutter_dome/home/router_example.dart';
 final routes = {
    '/': (context) => Home(),
    "/login": (context)=>Login(),
    '/home': (context) => Home(),
    '/event_list': (context, {arguments}) => News(),
    '/router_example': (context, {params}) => RouterExample(params: params),
    "/news_detail": (context,{params}) => NewsDetail(params: params),
  };

//固定写法
var onGenerateRoute=(RouteSettings settings) {
  
      // 统一处理
      final String name = settings.name; 
      final Function pageContentBuilder = routes[name];
      if (pageContentBuilder != null) {
        if (settings.arguments != null) {
          
          final Route route = MaterialPageRoute(
              builder: (context) =>
                  pageContentBuilder(context,params:settings.arguments));
          return route;
        }else{
            final Route route = MaterialPageRoute(
              builder: (context) =>
                  pageContentBuilder(context));
            return route;
        }
        
      }
      
};