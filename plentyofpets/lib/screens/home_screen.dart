import 'package:flutter/material.dart';
import 'package:plentyofpets/components/nav_drawer.dart';
import '../components/user_profile.dart';
import '../components/pets_list.dart';
import 'favorites_screen.dart';
import '../screens/news_feed.dart'; // stretch

class HomeScreen extends StatelessWidget {
  const HomeScreen({this.tabIndex = 0, this.petDocs, Key? key})
      : super(key: key);
  final int tabIndex;
  final List? petDocs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: tabIndex,
      length: 4,
      child: Scaffold(
        appBar: AppBar(),
        drawer: const Drawer(child: NavDrawer()),
        bottomNavigationBar: menu(),
        body: TabBarView(
          children: <Widget>[
            Center(
              // Display a list of pets from the database
              child: PetList(filteredPetDocs: petDocs),
            ),
            const Center(
              // Stretch goal
              child: NewsFeedScreen(),
            ),
            // Users saved pets list
            const Center(
              child: FavoritePets(),
            ),
            const Center(
              // Display the user profile page
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
