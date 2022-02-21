import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/components/pet_card.dart';
import 'package:plentyofpets/services/pet_database.dart';

// This class will be used to create and display a list of pets
class FavList extends StatelessWidget {
  const FavList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc
        ('${DatabaseService().getUser()}').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            value: null,
            semanticsLabel: 'Progress Indicator',
          );
        } else {
          var userFavs = snapshot.data?['favs'];
          return ListView.builder(
            itemCount: userFavs.length,
            itemBuilder: (context, index) {
              //print(userFavs[index]);
                var petInfo= FirebaseFirestore.instance.collection('pets').doc(
                  '${userFavs[index]}').get();
                print('hey');
                print(petInfo);
                return PetCard(
                  petInfo as Map<String,dynamic>,
                  '${DatabaseService().getUser()}'
                );
            },
            //return const Text('No current Favs');
          );
        }
      }
    );
  }
}