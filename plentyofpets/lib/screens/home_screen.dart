import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:plentyofpets/components/nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const Text('Home')
      ),
      drawer: const Drawer(
        child: NavDrawer()
      )
    );  
  }
}
