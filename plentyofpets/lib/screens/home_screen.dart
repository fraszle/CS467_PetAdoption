import 'package:flutter/material.dart';
import 'package:plentyofpets/components/nav_drawer.dart';
import '../components/user_profile.dart';
import '../components/pets_list.dart';
import '../screens/saved_pet_list_screen.dart';
import '../screens/news_feed.dart'; // stretch

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: Scaffold(
          appBar: AppBar(),
          drawer: const Drawer(child: NavDrawer()),
          bottomNavigationBar: menu(),
          body: const TabBarView(
            children: <Widget>[
              Center(
                // Display a list of pets from the database
                child: PetList(),
              ),
              Center(
                // Stretch goal
                child: NewsFeed(),
              ),
              // Users saved pets list
              Center(
                child: SavedPetList(),
              ),
              Center(
                // Display the user profile page
                child: UserProfile(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget menu() {
  return Container(
    color: const Color(0xFF3F5AA6),
    child: const TabBar(
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
