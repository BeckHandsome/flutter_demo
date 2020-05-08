import 'package:flutter/material.dart';
import './tabs.dart';
class Home extends StatefulWidget {
  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  @override
  Widget build(BuildContext context) {
    return Tabs();
  }
}


