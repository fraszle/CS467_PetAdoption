import 'package:flutter/material.dart';
import 'package:plentyofpets/screens/admin_homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfirmPetScreen extends StatelessWidget {
  // final Map <String,dynamic> petInfo;

  // const ConfirmPetScreen({Key? key, required this.petInfo}) : super(key: key);
  // CollectionReference pets = FirebaseFirestore.instance.collection('pets');


  // @override

  // Widget build(BuildContext context) {
  //   CollectionReference pets = FirebaseFirestore.instance.collection('pets');

  //   Future<void> addPet() {
  //     return pets.add({
  //       'name': petInfo['Pet Name']
  //     })
  //     .then((value)=> print('Pet added'))
  //     .catchError((error)=> print('Failed to add pet: $error'));
  //   }

  //   return FlatButton(
  //     onPressed: addPet,
  //     child: Text('Add Pet',
  //     ),
  //   );
  // }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('update'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AdminHomepage()));
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
