import 'package:flutter/material.dart';
import 'package:plentyofpets/components/extract_pet_basics.dart';
import 'package:plentyofpets/components/pet_profile_args.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:plentyofpets/services/pet_database.dart';

class PetCard extends StatefulWidget {
  const PetCard(this.doc, this.petID, {Key? key}) : super(key: key);

  final Map<String, dynamic> doc;
  final String petID;

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // When a Card is tapped, we navigate to that pet's profile
        onTap: () {
          Navigator.pushNamed(context, ExtractPetBasics.routeName,
              arguments: PetProfileArgs(widget.petID, widget.doc));
        },
        // Create a card with a ListTile that has pet info
        child: Card(
          elevation: 80,
          color: Color.fromARGB(255, 219, 240, 220),
          shadowColor: Color.fromARGB(255, 1, 27, 1),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Column(children:[
                Text(widget.doc['name'], style: const TextStyle(
                  fontFamily: 'IndieFlower',
                  fontSize:32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 248, 121, 17))),
                Expanded(
                  child: Container(
                    height:110,
                    child:CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 5, 173, 41),
                      radius: 70,
                      child:CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(widget.doc['mainPhoto'] ??
                          'https://images.unsplash.com/photo-1636654129379-e7ae6f30bfd0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80'), // Temp image in case pet doesn't have mainPhoto
                      ),
                    ),
                  ),
                ),
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Text(widget.doc['availability'],style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize:23,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 20, 77, 23))),
                Text('Type: ${widget.doc['type']}', style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize:23,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 20, 77, 23))),
                Text('Breed: ${widget.doc['breed']}', style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize:23,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 20, 77, 23)))
              ],),
              
                Align(
                  alignment: Alignment.topRight,
                  child:FavoriteButton(
                    isFavorite:false,
                    iconSize: 50,
                    // iconDisabledColor: Colors.white,
                    valueChanged: (_isFavorite) {
                      if(_isFavorite){
                        DatabaseService().addFav(widget.petID);
                      }else{ 
                        DatabaseService().deleteFav(widget.petID);}
                    }
                  )    
                ),
            ],)
          ),
        ));
  }
}
