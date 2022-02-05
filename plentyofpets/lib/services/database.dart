import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //final String id;
  
  //collection reference
  final CollectionReference petsCollection = FirebaseFirestore.instance.collection('pets');

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
      }).then((value){print(value.id);});
    }
}