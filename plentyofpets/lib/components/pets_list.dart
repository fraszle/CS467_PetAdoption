import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/components/pet_card.dart';
import 'package:plentyofpets/screens/home_filter_screen.dart';
import 'package:plentyofpets/screens/home_screen.dart';

// This class will be used to create and display a list of pets
class PetList extends StatelessWidget {
  PetList({this.petDocs, Key? key}) : super(key: key);

  List? petDocs;

  @override
  Widget build(BuildContext context) {
    if (petDocs == null) {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('pets').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong: ${snapshot.error}");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                value: null,
                semanticsLabel: 'Progress Indicator',
              );
            } else {
              // Get a list of all documents in the collections
              petDocs = snapshot.data!.docs;

              // Create a listview containing all pets in the database
              return Column(children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, HomeFilterScreen.routeName);
                    },
                    child: const Text('Filter List')),
                Flexible(
                    child: ListView.builder(
                        itemCount: petDocs?.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              petDocs?[index].data()! as Map<String, dynamic>;
                          return PetCard(data, petDocs?[index].id);
                        }))
              ]);
            }
          });
    } else if (petDocs!.isEmpty) {
      // In the event that no pets fit the filter criteria, return a message
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('No pets available!', style: TextStyle(color: Colors.red)),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(tabIndex: 0)));
              },
              child: const Text('Clear Filter')),
        ],
      );
    } else {
      // Create a ListView with each document from the filtered list
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(tabIndex: 0)));
                },
                child: const Text('Clear Filter')),
          ],
        ),
        Flexible(
            child: ListView.builder(
                itemCount: petDocs?.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      petDocs?[index].data()! as Map<String, dynamic>;
                  return PetCard(data, petDocs?[index].id);
                }))
      ]);
    }
  }
}
