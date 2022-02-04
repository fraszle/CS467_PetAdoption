import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:json_annotation/json_annotation.dart'

class Pets {

  final String type;
  final String availability;
  //final String disposition;
  final String breed;
  final String name;
  //final String description;

 // DocumentReference? reference;

  Pets({required this.name,required this.availability,required this.breed,required this.type});
} 
//pet list from snapshot
// List<Pets> _brewListFromSnapshot(QuerySnapshot snapshot){
//   return snapshot.documents.map(doc){
//     return Pet()
//   }
// }

//   factory Pets.fromJson(Map<dynamic, dynamic> json) =>
//     _petsFromJson(json);

//   Map<String, dynamic> toJson() => _PetsToJson(this);
//   @override
//   String toString() => "Pets<$pets>";
// }

// Pets _petsFromJson(Map<dynamic, dynamic> json) {
//   return Pets(
//     json['pets'] as String,
//     availability : json['availability'] as String,
//     breed : json['breed'] as String,
//     type : json['type'] as String,
//     name : json['name'] as String,
//   );
// }

  //final newPet = FirebaseFirestore.instance.collection('pets');
  //                     newPet.add({
  //                         'type': petFormData['PetType'],
  //                         'availability': petFormData['Availability'],
  //                         'disposition': petFormData['Disposition'],
  //                         'breed': petFormData['Breed'],
  //                         'name': petFormData['Pet Name'],
  //                         'description': petFormData['Description'],
  //                         'timestamp': FieldValue.serverTimestamp(),
  //                         '?':newPet.id

