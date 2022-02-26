import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/components/pet_card.dart';
import 'package:plentyofpets/services/pet_database.dart';


class FavPets extends StatefulWidget {
  const FavPets({ Key? key }) : super(key: key);

  @override
  _FavPetsState createState() => _FavPetsState();
}

class _FavPetsState extends State<FavPets> {
  
  //stream for current user doc
  final Stream<DocumentSnapshot> userStream = 
    FirebaseFirestore.instance.collection('users').
    doc('${DatabaseService().getUser()}').snapshots();
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: userStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        List favPets = snapshot.data!['favs'];  
        return FutureBuilder(
          future: DatabaseService().favPetDocs(favPets), 
          builder:(BuildContext context, AsyncSnapshot<dynamic> listFavPetDocs){
            if (listFavPetDocs.hasData){
              if(favPets.isNotEmpty){
                return ListView.builder(
                  itemCount: favPets.length,
                  itemBuilder: (context, index){
                    Map<String, dynamic> data =
                    listFavPetDocs.data[index].data()! as Map<String, dynamic>;
                    return PetCard(data, favPets[index]);
                  }
                );
              }else {return const Text('No favorites yet. Keep Looking!');}
            }else{
              return const CircularProgressIndicator();
            }
          }
        );  
      },
    );
  }
}
 //     ListView(