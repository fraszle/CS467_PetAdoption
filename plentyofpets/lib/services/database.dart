import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
  //final String id;
  
  
   DocumentReference? reference;
  //DatabaseService({required this.id});
  
  //collection reference
  final CollectionReference petsCollection = FirebaseFirestore.instance.collection('pets');
  
  // Future updatePetData(String type, String name) async{
  //   return await petsCollection.doc()

  Future addPet(petFormData) async {
    Map petData= {
                'type': petFormData['PetType'],
                'availability': petFormData['Availability'],
                'disposition': petFormData['Disposition'],
                'breed': petFormData['Breed'],
                'name': petFormData['Pet Name'],
                'description': petFormData['Description'],
                'timestamp': FieldValue.serverTimestamp(),};
    return await petsCollection.id;
  }

  // final newPet = FirebaseFirestore.instance.collection('pets');
  //                     newPet.add({
  //                         'type': petFormData['PetType'],
  //                         'availability': petFormData['Availability'],
  //                         'disposition': petFormData['Disposition'],
  //                         'breed': petFormData['Breed'],
  //                         'name': petFormData['Pet Name'],
  //                         'description': petFormData['Description'],
  //                         'timestamp': FieldValue.serverTimestamp(),
  //                         '?':newPet.id
}