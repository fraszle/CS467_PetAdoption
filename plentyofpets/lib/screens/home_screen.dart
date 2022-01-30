import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        bottomNavigationBar: menu(),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //AnimalProfileCardButton(),
                  ],
                ),
              ),
            ),
            Center(
              child: Text("News Feed page"),
            ),
            Center(
              child: Text("Saved animals page"),
            ),
            Center(
              child: Text("Account page"),
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
