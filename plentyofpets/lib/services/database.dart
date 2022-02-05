import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/models/pet_model.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String id='';
  
  //collection reference
  final CollectionReference petsCollection = FirebaseFirestore.instance.collection('pets');

  //adds new pet and captures pet id from add pet form
  Future addPet(var type,var availability,var disposition,var breed,
    var name,var description) async 
    {
      return await petsCollection.add
      ({
        'type': type,
        'availability':availability,
        'disposition':disposition,
        'breed':breed,
        'name': name,
        'description': description,
        'timestamp': FieldValue.serverTimestamp()
      }).then((value){return value.id;});
    }
    
    //adds pet detail to pet with pet id from add pet form
    Future addPetDetails(var petId,var description) async 
    {
      return await petsCollection.doc(petId).collection('pet_details').add
      ({
        'description': description,
      }).then((value){print("done");});
    }



//get stream of pets from snapshot
    Stream<List<Pets>> petStream = FirebaseFirestore.
      instance.collection('pets').snapshots().map(_petListFromSnapshot);

      
    //pet list from snapshot
    List<Pets> _petListFromSnapshot(QuerySnapshot snapshot){
      return snapshot.docs.map((doc){
        return Pets(
          name: doc.data['name'] ?? '',
          type: doc.data['type'] ?? '',
          breed: doc.data['breed'] ?? '',
          availability: doc.data['availability'] ?? '',
        );
      }).toList();
    }
   
}