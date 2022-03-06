import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';

import 'package:plentyofpets/components/extract_pet_basics.dart';
import 'package:plentyofpets/components/pet_profile_args.dart';
import 'package:plentyofpets/services/pet_database.dart';
import 'package:plentyofpets/theme.dart';

class PetCard extends StatefulWidget {
  const PetCard(this.doc, this.petID, {Key? key}) : super(key: key);

  final Map<String, dynamic> doc;
  final String petID;

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  
  //stream for current user doc
  final Stream<DocumentSnapshot> userStream = FirebaseFirestore.instance
      .collection('users')
      .doc('${DatabaseService().getUser()}')
      .snapshots();

  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: userStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        //determine if user is admin for favorite visibility
        bool visible = snapshot.data!['isAdmin'];

        //check card against current user favs to add favoriting
        List favPets = snapshot.data!['favs'];
        if (favPets.contains(widget.petID)) {
          isFav = true;
        }
        return GestureDetector(
          // When a Card is tapped, we navigate to that pet's profile
          onTap: () {
            Navigator.pushNamed(context, ExtractPetBasics.routeName,
              arguments: PetProfileArgs(widget.petID, widget.doc));
          },
          // Create a card that has pet info
          child: Card(
            key: ValueKey<String>(widget.petID),
            elevation: 80,
            color: const Color.fromARGB(255, 219, 240, 220),
            shadowColor: const Color.fromARGB(255, 1, 27, 1),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Text(widget.doc['name'],
                        style: PlentyOfPetsTheme.petCardName,),
                    Expanded(
                      child: SizedBox(
                        height: 110,
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 5, 173, 41),
                          radius: 70,
                          child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(widget
                                  .doc['mainPhoto'] ??
                              'https://images.unsplash.com/photo-1636654129379-e7ae6f30bfd0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80'), // Temp image in case pet doesn't have mainPhoto
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.doc['availability'],
                            style: PlentyOfPetsTheme.petCardText,),
                        Text('Type: ${widget.doc['type']}',
                            style: PlentyOfPetsTheme.petCardText,),
                        Text('Breed: ${widget.doc['breed']}',
                            textAlign: TextAlign.center,
                            style: PlentyOfPetsTheme.petCardText,),
                      ],
                    ),
                  ),

                    //favoriting heart that is not visible to admin
                  Offstage(
                    offstage: visible,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FavoriteButton(
                        key: ValueKey<String>(widget.petID),
                        isFavorite: isFav,
                        iconSize: 50,
                        //add or delete pet id from firebase on click
                        valueChanged: (_isFavorite) {
                          if (_isFavorite) {
                            DatabaseService().addFav(widget.petID);
                          } else {
                            DatabaseService().deleteFav(widget.petID);
                          }
                        }
                      )
                    ),
                  ),
                  ],
                )
              ),
          )
        );
      });
  }
}
