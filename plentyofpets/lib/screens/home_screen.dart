import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/components/nav_drawer.dart';
import 'user_profile.dart';
import '../components/pets_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(),
        drawer: const Drawer(child: NavDrawer()),
        bottomNavigationBar: menu(),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: PetList(),
            ),
            Center(
              child: Text("News Feed page"),
            ),
            Center(
              child: Text("Saved animals page"),
            ),
            Center(
              child: UserProfile(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget menu() {
  return Container(
    color: Color(0xFF3F5AA6),
    child: TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.blueGrey,
      tabs: [
        Tab(
          text: "Home",
          icon: Icon(Icons.pets),
        ),
        Tab(
          text: "News",
          icon: Icon(Icons.description),
        ),
        Tab(
          text: "Saved",
          icon: Icon(Icons.favorite),
        ),
        Tab(
          text: "Account",
          icon: Icon(Icons.account_circle),
        ),
      ],
    ),
  );
}
