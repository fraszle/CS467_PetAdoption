import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String id='';
  
  //collection reference
  final CollectionReference petsCollection = FirebaseFirestore.instance.collection('pets');

  //adds new pet and captures pet id from add pet form
  Future addPet(var type,var availability,var disposition,var breed,
    var name) async 
    {
      return await petsCollection.add
      ({
        'type': type,
        'availability':availability,
        'disposition':disposition,
        'breed':breed,
        'name': name,
        'timestamp': FieldValue.serverTimestamp()
      }).then((value){return value.id;});
    }
    
    //adds pet detail to pet with pet id from add pet form
    Future addPetDetails(var petId,var description, var name, var photos) async 
    {
      return await petsCollection.doc(petId).collection('pet_details').add
      ({
        'description': description,
        'name':name,
        'photos':photos
      });
    }
}